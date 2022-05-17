# cassandra-exporter

[Apache Cassandra](https://cassandra.apache.org) is a free and open-source distributed database management system designed to handle large amounts of data across many commodity servers or datacenters.

## Introduction

Cassandra exporter is used as a Application AccessCenter within KubeGems Observability. Make sure the remote JMX port is enabled for the Cassandra service before install. 

## Prerequisites

- Kubernetes 1.12+
- Helm 3.1.0
- PV provisioner support in the underlying infrastructure

### Cassandra exporter parameters

| Parameter                     | Description                                                                                                                                         | Default                                                 |
|-------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------|
| `image.repository`            | Cassandra exporter Image name                                                                                                                                | `registry.cn-beijing.aliyuncs.com/kubegemsapp/cassandra-exporter`                                     |
| `image.tag`                   | Cassandra exporter Image tag                                                                                                                                 | `{TAG_NAME}`                                            |
| `image.pullPolicy`            | Image pull policy                                                                                                                                   | `IfNotPresent`                                          |
| `host`            | Cassandra host | `cassandra:7199`                                          |
| `username`            | Cassandra username | `gems`                                          |
| `password`            | Cassandra password| `cloud1688`                                          |