CHARTS_UPLOADER ?= registry.cn-beijing.aliyuncs.com/kubegems/appstore-charts:latest

all: package release

package:
	rm -rf charts/*.tgz
	bash generate_repo.sh

dry-run:
	bash helm_dry_run.sh

release:
	docker buildx build -t $(CHARTS_UPLOADER) --push  --platform=linux/amd64,linux/arm64 -f Dockerfile .

init-chartmuseum:
	bash init_chartmuseum.sh

apply:
	#kubectl delete job appstore-charts
	kubectl create job appstore-charts --image=$(CHARTS_UPLOADER)
