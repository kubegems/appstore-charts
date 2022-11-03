package main

import (
	"bytes"
	"flag"
	"fmt"
	"io"
	"os"
	"path"
	"regexp"

	"kubegems.io/kubegems/pkg/service/models"
	"kubegems.io/kubegems/pkg/service/observe"
	"kubegems.io/kubegems/pkg/utils/prometheus/channels"
	"sigs.k8s.io/yaml"
)

var (
	exporter string
	dir      string
)

func init() {
	flag.StringVar(&exporter, "exporter", "prometheus-mysql-exporter", "target exporter charts name")
	flag.StringVar(&dir, "dir", "", "exporter charts dir")

	flag.Parse()
}

const (
	fullnameTpl  = "__fullname__"
	namespaceTpl = "__namespace__"
)

func main() {
	exporterPath := path.Join(dir, exporter)
	alerts := []observe.MonitorAlertRule{}
	file, err := os.Open(path.Join(exporterPath, "alerts.yaml"))
	if err != nil {
		panic(err)
	}
	bts, err := io.ReadAll(file)
	if err != nil {
		panic(err)
	}
	if err := yaml.Unmarshal(bts, &alerts); err != nil {
		panic(err)
	}

	tplGetter := models.NewPromqlTplMapperFromFile().FindPromqlTpl
	raw := &observe.RawMonitorAlertResource{
		Base: &observe.BaseAlertResource{
			AMConfig: observe.GetBaseAlertmanagerConfig(namespaceTpl, fullnameTpl),
			ChannelGetter: func(id uint) (channels.ChannelIf, error) {
				if id == 1 {
					return models.DefaultChannel.ChannelConfig.ChannelIf, nil
				}
				return nil, fmt.Errorf("channel %d not found", id)
			},
		},
		PrometheusRule: observe.GetBasePrometheusRule(namespaceTpl, fullnameTpl),
		TplGetter:      tplGetter,
	}

	for i := range alerts {
		if len(alerts[i].Receivers) == 0 {
			continue
		}
		alerts[i].Source = fullnameTpl
		alerts[i].Receivers[0].AlertChannel = models.DefaultChannel
		if err := observe.MutateMonitorAlert(&alerts[i], tplGetter); err != nil {
			panic(err)
		}
		if err := raw.ModifyAlertRule(alerts[i], observe.Add); err != nil {
			panic(err)
		}
	}

	os.WriteFile(path.Join(exporterPath, "templates/alertmanagerconfig.yaml"), getOutput(raw.Base.AMConfig), 0644)
	os.WriteFile(path.Join(exporterPath, "templates/prometheusrule.yaml"), getOutput(raw.PrometheusRule), 0644)
	fmt.Printf("generate exporter %s succeed\n", exporter)
}

var reg = regexp.MustCompile("{{ %")

func getOutput(obj interface{}) []byte {
	bts, _ := yaml.Marshal(obj)
	// 对不需要替换的'{{`', '}}'转义，https://stackoverflow.com/questions/17641887/how-do-i-escape-and-delimiters-in-go-templates

	bts = bytes.ReplaceAll(bts, []byte("{{"), []byte(`{{"{{"}}`))
	// bts = bytes.ReplaceAll(bts, []byte("}}]"), []byte(`{{"}}"}}]`))
	bts = bytes.ReplaceAll(bts, []byte(fullnameTpl), []byte(fmt.Sprintf(`{{ template "%s.fullname" . }}`, exporter)))
	bts = bytes.ReplaceAll(bts, []byte(namespaceTpl), []byte("{{ .Release.Namespace }}"))
	buf := bytes.NewBuffer([]byte("{{- if .Values.alerts.enabled -}}\n"))
	buf.Write(bts)
	buf.Write([]byte("{{- end }}"))

	return buf.Bytes()
}
