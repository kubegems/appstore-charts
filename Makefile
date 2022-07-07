CHARTS_UPLOADER ?= docker.io/kubegems/appstore-charts:latest

package:
	 rm -rf charts/*.tgz
	 bash generate_repo.sh

dry-run:
	 bash helm_dry_run.sh

build:
	 docker build -t $(CHARTS_UPLOADER) -f Dockerfile .

build-push:
	 docker build -t $(CHARTS_UPLOADER) -f Dockerfile .
	 docker push $(CHARTS_UPLOADER)

init-chartmuseum:
	 bash init_chartmuseum.sh

apply:
	#kubectl delete job appstore-charts
	kubectl create job appstore-charts --image=$(CHARTS_UPLOADER)

generate:
	bash generate_alerts.sh