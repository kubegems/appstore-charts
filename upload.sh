#!/bin/sh

set -x

CHARTMUSEUM_ADDR="http://kubegems-chartmuseum:8080"
CHARTS_DIR="/uploader/charts"
REPO=kubegems
WAIT=0

usage() {
    echo "Upload helm charts to chartmuseum"
    echo ""
    echo "Example: $0 --server http://chartmuseum.example.com --repo myrepo charts/"
    echo ""
    echo "Usage: $0 [options...] <charts_dir>"
    echo ""
    echo "Options:"
    echo "-s,--server           server address of chartmuseum. Default: $CHARTMUSEUM_ADDR"
    echo "-r,--repo             repo to upload charts. Default: $REPO"
    echo "-w,--wait             wait util chartmuseum available."
    echo "-h,--help             show help message."
    exit 1
}

wait() {
    echo "waiting for chartmuseum $1 available."
    while true; do
        code=$(curl -sL -w "%{http_code}" "$1" -o /dev/null)
        echo "chartmuseum $1: http_code=$code"
        [ "$code" = "200" ] && break
        sleep 5
    done
    echo "chartmuseum $1 is available."
}

upload() {
    echo "uploading ${1} to server ${2} repo ${3}"
    for file in $(find ${1} -name "*.tgz"); do
        echo "uploading ${file}"
        curl --data-binary "@${file}" -w "%{stdout}\n" ${2}/api/${3}/charts
    done
}

OPTS=$(getopt -o s:,w,r:,h -l server:,wait,repo:,help -- "$@")
if [ $? != 0 ]; then
    usage
fi
eval set -- "$OPTS"
while true; do
    case $1 in
    -s | --server)
        CHARTMUSEUM_ADDR=$2
        shift 2
        ;;
    -r | --repo)
        REPO=$2
        shift 2
        ;;
    -w | --wait)
        shift
        WAIT=1
        ;;
    -h | --help)
        usage
        ;;
    --)
        shift
        break
        ;;
    *)
        echo "unexpected option: $1"
        usage
        ;;
    esac
done

#if [ ! -z $1 ]; then
#    CHARTS_DIR=$1
#fi

if [ ! -d $CHARTS_DIR ]; then
    echo "charts_dir $CHARTS_DIR not exist."
    exit 1
fi

if [ ! $WAIT = 0 ]; then
    wait ${CHARTMUSEUM_ADDR} ${WAIT}
fi

upload ${CHARTS_DIR} ${CHARTMUSEUM_ADDR} ${REPO}

exit 0
