#!/bin/bash

function green(){
    echo -e "\033[32m$1\033[0m"
}

function bred(){
    echo -e "\033[31m\033[01m$1\033[0m"
}

CHARTS_DIR='charts'
ROOTDIR='.'

mkdir -p $CHARTS_DIR

# 打包
ls | while read myline; do
  # 如果对象名不包含cloud-则跳过

  # 非目录跳过
  [[ ! -d ${myline} ]] && {
    continue
  }

  [[ ${myline} == "charts" ]] && {
    continue
  }

  #打包
  green "packaging $myline "
  helm package $myline
  if [[ $? -ne 0 ]]; then
      bred "helm package $myline error!!!"
      exit 255
  else
      continue
  fi
done

#将pkg移动到gems目录
find . -name '*.tgz' | while read file; do mv $file $CHARTS_DIR/; done

