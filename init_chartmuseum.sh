#!/bin/bash

cat << EOF > chartmuseum.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app.kubernetes.io/name: gems-chartmuseum
  name: gems-chartmuseum
spec:
  replicas: 1
  selector:
    matchLabels:
      app.kubernetes.io/name: gems-chartmuseum
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      labels:
        app.kubernetes.io/name: gems-chartmuseum
    spec:
      containers:
      - image: kubegems/gems-chartmuseum:v0.13.0
        imagePullPolicy: IfNotPresent
        args:
        - --depth=1
        - --port=8030
        - --storage=local
        - --storage-local-rootdir=/data/charts
        name: gems-chartmuseum
        ports:
        - containerPort: 8030
          name: http-8030
      restartPolicy: Always
---
apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/name: gems-chartmuseum
  name: gems-chartmuseum
spec:
  ports:
  - name: http-8030
    port: 8030
    protocol: TCP
    targetPort: 8030
  selector:
    app.kubernetes.io/name: gems-chartmuseum
  type: ClusterIP
EOF

kubectl apply -f ./chartmuseum.yaml