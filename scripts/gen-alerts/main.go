package main

import (
	"bytes"
	"flag"
	"fmt"
	"io"
	"os"
	"path"
	"regexp"

	"github.com/ghodss/yaml"
	"kubegems.io/kubegems/pkg/utils/prometheus"
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
	alerts := []prometheus.MonitorAlertRule{}
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

	raw := &prometheus.RawMonitorAlertResource{
		Base: &prometheus.BaseAlertResource{
			AMConfig: prometheus.GetBaseAlertmanagerConfig(namespaceTpl, fullnameTpl),
		},
		PrometheusRule: prometheus.GetBasePrometheusRule(namespaceTpl, fullnameTpl),
		MonitorOptions: prometheus.DefaultMonitorOptions(),
	}

	for _, alert := range alerts {
		alert.Source = fullnameTpl
		if err := alert.CheckAndModify(raw.MonitorOptions); err != nil {
			panic(err)
		}
		if err := raw.ModifyAlertRule(alert, prometheus.Add); err != nil {
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
