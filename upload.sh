#!/bin/sh

code=0
while [ ! $code == 200 ];do
     code=`curl -sL -w "%{http_code}\\n" "http://gems-chartmuseum:8030" -o /dev/null`
     sleep 1
done


echo "chartmuseum is available"

for chart in `ls charts`;do
    curl --data-binary "@charts/${chart}" http://gems-chartmuseum:8030/api/kubegemsapp/charts
    echo "------------------------------"
done

exit 0
