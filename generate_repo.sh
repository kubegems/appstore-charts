#!/bin/bash

green() {
  echo "\033[32m$1\033[0m"
}

bred() {
  echo "\033[31m\033[01m$1\033[0m"
}

CHARTS_DIR='charts'
ROOTDIR='.'

# 打包
charts=$(find ${ROOTDIR} -maxdepth 1 -mindepth 1 -type d -not -name '.*' -not -name ${CHARTS_DIR} -printf '%f\n')
for chart in $charts; do
  green "打包 $chart"
  helm package -d $CHARTS_DIR $chart
  if [ $? -ne 0 ]; then
    bred "helm package $myline error!!!"
    exit 255
  fi
done
