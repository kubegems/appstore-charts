#!/bin/bash

function green(){
    echo -e "\033[32m$1\033[0m"
}

function bred(){
    echo -e "\033[31m\033[01m$1\033[0m"
}

CHARTS_DIR='charts'
ROOTDIR='.'

ls | while read myline; do
  # 如果对象名不包含cloud-则跳过
  # 非目录跳过
  [[ ! -d ${myline} ]] && {
    continue
  }

  [[ ${myline} == "charts" ]] && {
    continue
  }

  [[ ${myline} == "istio-bookinfo" ]] && {
    continue
  }

  #打包
  green ">>>>>> Templating Charts $myline" 
  helm template $myline | kubectl apply --dry-run=server -f -
  if [[ $? -ne 0 ]]; then
      bred "application: $myline apply error!!!"
      exit 255
  else
      continue
  fi
done
