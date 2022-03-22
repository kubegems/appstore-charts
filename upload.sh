#!/bin/sh

code=0
HOST=${CHARTMUSEUM_HOST:-"gems-chartmuseum:8030"}
INNER=${KUBEGEMS_INNER_REPONAME:-"kubegems-appstore"}
while [ ! $code == 200 ];do
     code=`curl -sL -w "%{http_code}\\n" "http://${HOST}" -o /dev/null`
     echo "`date` chartmuseum not start; wait 1s"
     sleep 1
done


echo "chartmuseum is available"

for chart in `ls charts`;do
    curl --data-binary "@charts/${chart}" http://${HOST}/api/${INNER}/charts
    echo "\n------------------------------"
done

exit 0
