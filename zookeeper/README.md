# Zookeeper

基于bitnami zookeeper

# ZooKeeper

[ZooKeeper](https://zookeeper.apache.org/) 是用于维护配置信息、命名、提供分布式同步和提供组服务的集中服务。所有这些类型的服务都被分布式应用程序以某种形式或其他形式使用。

## 安装

```console
$ helm repo add bitnami https://charts.bitnami.com/bitnami
$ helm install bitnami/zookeeper
```

## 需求

- Kubernetes 1.12+
- Helm 2.11+ or Helm 3.0-beta3+
- PV provisioner support in the underlying infrastructure

## 参数

| Parameter                              | Description                                                                                                                                               | Default                                                      |  |
|----------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------|--|
| `global.imageRegistry`                 | Global Docker image registry                                                                                                                              | `nil`                                                        |  |
| `global.imagePullSecrets`              | Global Docker registry secret names as an array                                                                                                           | `[]` (does not add image pull secrets to deployed pods)      |  |
| `global.storageClass`                  | Global storage class for dynamic provisioning                                                                                                             | `nil`                                                        |  |
| `image.registry`                       | ZooKeeper image registry                                                                                                                                  | `docker.io`                                                  |  |
| `image.repository`                     | ZooKeeper Image name                                                                                                                                      | `bitnami/zookeeper`                                          |  |
| `image.tag`                            | ZooKeeper Image tag                                                                                                                                       | `{TAG_NAME}`                                                 |  |
| `image.pullPolicy`                     | ZooKeeper image pull policy                                                                                                                               | `IfNotPresent`                                               |  |
| `image.pullSecrets`                    | Specify docker-registry secret names as an array                                                                                                          | `[]` (does not add image pull secrets to deployed pods)      |  |
| `image.debug`                          | Specify if debug values should be set                                                                                                                     | `false`                                                      |  |
| `nameOverride`                         | String to partially override zookeeper.fullname template with a string (will append the release name)                                                     | `nil`                                                        |  |
| `fullnameOverride`                     | String to fully override zookeeper.fullname template with a string                                                                                        | `nil`                                                        |  |
| `volumePermissions.enabled`            | Enable init container that changes volume permissions in the data directory (for cases where the default k8s `runAsUser` and `fsUser` values do not work) | `false`                                                      |  |
| `volumePermissions.image.registry`     | Init container volume-permissions image registry                                                                                                          | `docker.io`                                                  |  |
| `volumePermissions.image.repository`   | Init container volume-permissions image name                                                                                                              | `bitnami/minideb`                                            |  |
| `volumePermissions.image.tag`          | Init container volume-permissions image tag                                                                                                               | `stretch`                                                    |  |
| `volumePermissions.image.pullPolicy`   | Init container volume-permissions image pull policy                                                                                                       | `Always`                                                     |  |
| `volumePermissions.resources`          | Init container resource requests/limit                                                                                                                    | `nil`                                                        |  |
| `updateStrategy`                       | Update strategies                                                                                                                                         | `RollingUpdate`                                              |  |
| `podDisruptionBudget.maxUnavailable`   | Max number of pods down simultaneously                                                                                                                    | `1`                                                          |  |
| `rollingUpdatePartition`               | Partition update strategy                                                                                                                                 | `nil`                                                        |  |
| `clusterDomain`                        | Kubernetes cluster domain                                                                                                                                 | `cluster.local`                                              |  |
| `podManagementPolicy`                  | Pod management policy                                                                                                                                     | `Parallel`                                                   |  |
| `replicaCount`                         | Number of ZooKeeper nodes                                                                                                                                 | `1`                                                          |  |
| `tickTime`                             | Basic time unit in milliseconds used by ZooKeeper for heartbeats                                                                                          | `2000`                                                       |  |
| `initLimit`                            | Time the ZooKeeper servers in quorum have to connect to a leader                                                                                          | `10`                                                         |  |
| `syncLimit`                            | How far out of date a server can be from a leader                                                                                                         | `5`                                                          |  |
| `maxClientCnxns`                       | Number of concurrent connections that a single client may make to a single member                                                                         | `60`                                                         |  |
| `fourlwCommandsWhitelist`              | A list of comma separated Four Letter Words commands to use                                                                                               | `srvr, mntr`                                                 |  |
| `allowAnonymousLogin`                  | Allow to accept connections from unauthenticated users                                                                                                    | `yes`                                                        |  |
| `auth.existingSecret`                  | Use existing secret (ignores previous password)                                                                                                           | `nil`                                                        |  |
| `auth.enabled`                         | Enable ZooKeeper auth                                                                                                                                     | `false`                                                      |  |
| `auth.clientUser`                      | User that will use ZooKeeper clients to auth                                                                                                              | `nil`                                                        |  |
| `auth.clientPassword`                  | Password that will use ZooKeeper clients to auth                                                                                                          | `nil`                                                        |  |
| `auth.serverUsers`                     | List of user to be created                                                                                                                                | `nil`                                                        |  |
| `auth.serverPasswords`                 | List of passwords to assign to users when created                                                                                                         | `nil`                                                        |  |
| `heapSize`                             | Size in MB for the Java Heap options (Xmx and XMs)                                                                                                        | `[]`                                                         |  |
| `logLevel`                             | Log level of ZooKeeper server                                                                                                                             | `ERROR`                                                      |  |
| `jvmFlags`                             | Default JVMFLAGS for the ZooKeeper process                                                                                                                | `nil`                                                        |  |
| `config`                               | Configure ZooKeeper with a custom zoo.conf file                                                                                                           | `nil`                                                        |  |
| `service.type`                         | Kubernetes Service type                                                                                                                                   | `ClusterIP`                                                  |  |
| `service.port`                         | ZooKeeper port                                                                                                                                            | `2181`                                                       |  |
| `service.followerPort`                 | ZooKeeper follower port                                                                                                                                   | `2888`                                                       |  |
| `service.electionPort`                 | ZooKeeper election port                                                                                                                                   | `3888`                                                       |  |
| `service.publishNotReadyAddresses`     | If the ZooKeeper headless service should publish DNS records for not ready pods                                                                           | `true`                                                       |  |
| `securityContext.enabled`              | Enable security context (ZooKeeper master pod)                                                                                                            | `true`                                                       |  |
| `securityContext.fsGroup`              | Group ID for the container (ZooKeeper master pod)                                                                                                         | `1001`                                                       |  |
| `securityContext.runAsUser`            | User ID for the container (ZooKeeper master pod)                                                                                                          | `1001`                                                       |  |
| `persistence.enabled`                  | Enable persistence using PVC                                                                                                                              | `true`                                                       |  |
| `persistence.storageClass`             | PVC Storage Class for ZooKeeper volume                                                                                                                    | `nil`                                                        |  |
| `persistence.accessModes`              | PVC Access Mode for ZooKeeper volume                                                                                                                      | `ReadWriteOnce`                                              |  |
| `persistence.size`                     | PVC Storage Request for ZooKeeper volume                                                                                                                  | `8Gi`                                                        |  |
| `persistence.annotations`              | Annotations for the PVC                                                                                                                                   | `{}`                                                         |  |
| `nodeSelector`                         | Node labels for pod assignment                                                                                                                            | `{}`                                                         |  |
| `tolerations`                          | Toleration labels for pod assignment                                                                                                                      | `[]`                                                         |  |
| `affinity`                             | Map of node/pod affinities                                                                                                                                | `{}`                                                         |  |
| `resources`                            | CPU/Memory resource requests/limits                                                                                                                       | Memory: `256Mi`, CPU: `250m`                                 |  |
| `livenessProbe.enabled`                | Would you like a livenessProbe to be enabled                                                                                                              | `true`                                                       |  |
| `livenessProbe.initialDelaySeconds`    | Delay before liveness probe is initiated                                                                                                                  | 30                                                           |  |
| `livenessProbe.periodSeconds`          | How often to perform the probe                                                                                                                            | 10                                                           |  |
| `livenessProbe.timeoutSeconds`         | When the probe times out                                                                                                                                  | 5                                                            |  |
| `livenessProbe.failureThreshold`       | Minimum consecutive failures for the probe to be considered failed after having succeeded                                                                 | 6                                                            |  |
| `livenessProbe.successThreshold`       | Minimum consecutive successes for the probe to be considered successful after having failed                                                               | 1                                                            |  |
| `readinessProbe.enabled`               | Would you like a readinessProbe to be enabled                                                                                                             | `true`                                                       |  |
| `readinessProbe.initialDelaySeconds`   | Delay before liveness probe is initiated                                                                                                                  | 5                                                            |  |
| `readinessProbe.periodSeconds`         | How often to perform the probe                                                                                                                            | 10                                                           |  |
| `readinessProbe.timeoutSeconds`        | When the probe times out                                                                                                                                  | 5                                                            |  |
| `readinessProbe.failureThreshold`      | Minimum consecutive failures for the probe to be considered failed after having succeeded                                                                 | 6                                                            |  |
| `readinessProbe.successThreshold`      | Minimum consecutive successes for the probe to be considered successful after having failed                                                               | 1                                                            |  |
| `metrics.enabled`                      | Start a side-car prometheus exporter                                                                                                                      | `false`                                                      |  |
| `metrics.image.registry`               | ZooKeeper exporter image registry                                                                                                                         | `docker.io`                                                  |  |
| `metrics.image.repository`             | ZooKeeper exporter image name                                                                                                                             | `bitnami/zookeeper-exporter`                                 |  |
| `metrics.image.tag`                    | ZooKeeper exporter image tag                                                                                                                              | `{TAG_NAME}`                                                 |  |
| `metrics.image.pullPolicy`             | Image pull policy                                                                                                                                         | `IfNotPresent`                                               |  |
| `metrics.image.pullSecrets`            | Specify docker-registry secret names as an array                                                                                                          | `nil`                                                        |  |
| `metrics.podLabels`                    | Additional labels for Metrics exporter pod                                                                                                                | `{}`                                                         |  |
| `metrics.podAnnotations`               | Additional annotations for Metrics exporter pod                                                                                                           | `{prometheus.io/scrape: "true", prometheus.io/port: "9141"}` |  |
| `metrics.resources`                    | Exporter resource requests/limit                                                                                                                          | Memory: `256Mi`, CPU: `100m`                                 |  |
| `metrics.tolerations`                  | Exporter toleration labels for pod assignment                                                                                                             | `[]`                                                         |  |
| `metrics.nodeSelector`                 | Node labels for pod assignment                                                                                                                            | `{}`                                                         |  |
| `metrics.affinity`                     | Map of node/pod affinities                                                                                                                                | `{}`                                                         |  |
| `metrics.timeoutSeconds`               | Timeout in seconds the exporter uses to scrape its targets                                                                                                | 3                                                            |  |
| `metrics.serviceMonitor.enabled`       | if `true`, creates a Prometheus Operator ServiceMonitor (also requires `metrics.enabled` to be `true`)                                                    | `false`                                                      |  |
| `metrics.serviceMonitor.namespace`     | Namespace in which Prometheus is running                                                                                                                  | `nil`                                                        |  |
| `metrics.serviceMonitor.interval`      | Interval at which metrics should be scraped.                                                                                                              | `nil` (Prometheus Operator default value)                    |  |
| `metrics.serviceMonitor.scrapeTimeout` | Timeout after which the scrape is ended                                                                                                                   | `nil` (Prometheus Operator default value)                    |  |
| `metrics.serviceMonitor.selector`      | Prometheus instance selector labels                                                                                                                       | `nil`                                                        |  |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install --name my-release \
  --set auth.clientUser=newUser \
    bitnami/zookeeper
```

The above command sets the ZooKeeper user to `newUser`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml bitnami/zookeeper
```

> **Tip**: You can use the default [values.yaml](values.yaml)
