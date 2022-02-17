# 一. Memcached

### 1. 简介
Memcached(1.5.22)服务，支持如下功能:

- 单节点部署
- 监控服务自动发现

### 2. 参数
如果存在父charts需要requirement当前charts，部分变量需要传递下来，目前常见覆盖的变量如下：

| Parameter         | Description         | Default     | Default Value                |
| ---               | ---                 | ---         | ---                          |
| `nameOverride`    | 实例和Service的命名 | .Chart.Name | cloud-memcached              |
| `architecture`    | 实例模式            | standalone  | standalone,high-availability |
| `nodeSelector`    | Node亲和性调度      | null        | null                         |
| `tolerations`     | 调度容忍            | null        | null                         |
| `metrics.enabled` | 监控开关            | null        | true                         |

### 3. 样例
#### 3.1 直接部署
直接通过helm部署memcache执行以下即可：

- 下载cloud-memcached的charts包
- 解压并进入到charts目录
- 执行命令安装

```
helm template --name stable --namespace <namespace> --set nameOverride=<memcache服务名>  . - | kubectl apply -f -
```

#### 3.2 应用Charts引用

应用Helm如需应用MYSQL中间件，请参考如下步骤


- 在values.yaml自定义参数

```
memcached:
  nameOverride: smartvoice-memcached
```

# 二、原生Memcached

## 更多参数

| Parameter                     | Description                                                                                            | Default                                                      |
| ----------------------------- | ------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------ |
| `global.imageRegistry`        | Global Docker image registry                                                                           | `nil`                                                        |
| `global.imagePullSecrets`     | Global Docker registry secret names as an array                                                        | `[]` (does not add image pull secrets to deployed pods)      |
| `image.registry`              | Memcached image registry                                                                               | `docker.io`                                                  |
| `image.repository`            | Memcached Image name                                                                                   | `bitnami/memcached`                                          |
| `image.tag`                   | Memcached Image tag                                                                                    | `{TAG_NAME}`                                                 |
| `image.pullPolicy`            | Memcached image pull policy                                                                            | `IfNotPresent`                                               |
| `image.pullSecrets`           | Specify docker-registry secret names as an array                                                       | `[]` (does not add image pull secrets to deployed pods)      |
| `nameOverride`                | String to partially override memcached.fullname template with a string (will prepend the release name) | `nil`                                                        |
| `fullnameOverride`            | String to fully override memcached.fullname template with a string                                     | `nil`                                                        |
| `clusterDomain`               | Kubernetes cluster domain                                                                              | `cluster.local`                                              |
|`replicas`                     | Number of containers                                                                                   | `1`                                                          |
|`extraEnv`                     | Additional env vars to pass                                                                            | `{}`                                                         |
|`arguments`                    | Arguments to pass                                                                                      | `["/run.sh"]`                                                |
| `memcachedUsername`           | Memcached admin user                                                                                   | `nil`                                                        |
| `memcachedPassword`           | Memcached admin password                                                                               | `nil`                                                        |
| `service.type`                | Kubernetes service type for Memcached                                                                  | `ClusterIP`                                                  |
| `service.port`                | Memcached service port                                                                                 | `11211`                                                      |
| `service.clusterIP`           | Specific cluster IP when service type is cluster IP. Use `None` for headless service                   | `nil`                                                        |
| `service.nodePort`            | Kubernetes Service nodePort                                                                            | `nil`                                                        |
| `service.loadBalancerIP`      | `loadBalancerIP` if service type is `LoadBalancer`                                                     | `nil`                                                        |
| `service.annotations`         | Additional annotations for Memcached service                                                           | `{}`                                                         |
| `resources.requests`          | CPU/Memory resource requests                                                                           | `{memory: "256Mi", cpu: "250m"}`                             |
| `resources.limits`            | CPU/Memory resource limits                                                                             | `{}`                                                         |
| `persistence.enabled`         | Enable persistence using PVC                                                                           | `true`                                                       |
| `persistence.storageClass`    | PVC Storage Class for Jenkins volume                                                                   | `nil` (uses alpha storage class annotation)                  |
| `persistence.accessMode`      | PVC Access Mode for Jenkins volume                                                                     | `ReadWriteOnce`                                              |
| `persistence.size`            | PVC Storage Request for Jenkins volume                                                                 | `8Gi`                                                        |
| `securityContext.enabled`     | Enable security context                                                                                | `true`                                                       |
| `securityContext.fsGroup`     | Group ID for the container                                                                             | `1001`                                                       |
| `securityContext.runAsUser`   | User ID for the container                                                                              | `1001`                                                       |
| `securityContext.readOnlyRootFilesystem` | Enable read-only filesystem                                                                 | `false`                                                      |
| `podAnnotations`              | Pod annotations                                                                                        | `{}`                                                         |
| `affinity`                    | Map of node/pod affinities                                                                             | `{}` (The value is evaluated as a template)                  |
| `nodeSelector`                | Node labels for pod assignment                                                                         | `{}` (The value is evaluated as a template)                  |
| `tolerations`                 | Tolerations for pod assignment                                                                         | `[]` (The value is evaluated as a template)                  |
| `metrics.enabled`             | Start a side-car prometheus exporter                                                                   | `false`                                                      |
| `metrics.image.registry`      | Memcached exporter image registry                                                                      | `docker.io`                                                  |
| `metrics.image.repository`    | Memcached exporter image name                                                                          | `bitnami/memcached-exporter`                                 |
| `metrics.image.tag`           | Memcached exporter image tag                                                                           | `{TAG_NAME}`                                                 |
| `metrics.image.pullPolicy`    | Image pull policy                                                                                      | `IfNotPresent`                                               |
| `metrics.image.pullSecrets`   | Specify docker-registry secret names as an array                                                       | `[]` (does not add image pull secrets to deployed pods)      |
| `metrics.podAnnotations`      | Additional annotations for Metrics exporter                                                            | `{prometheus.io/scrape: "true", prometheus.io/port: "9150"}` |
| `metrics.resources`           | Exporter resource requests/limit                                                                       | `{}`                                                         |
| `metrics.service.type`        | Kubernetes service type for Prometheus metrics                                                         | `ClusterIP`                                                  |
| `metrics.service.port`        | Prometheus metrics service port                                                                        | `9150`                                                       |
| `metrics.service.annotations` | Prometheus exporter svc annotations                                                                    | `{prometheus.io/scrape: "true", prometheus.io/port: "9150"}` |

The above parameters map to the env variables defined in [bitnami/memcached](http://github.com/bitnami/bitnami-docker-memcached). For more information please refer to the [bitnami/memcached](http://github.com/bitnami/bitnami-docker-memcached) image documentation.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install my-release --set memcachedUsername=user,memcachedPassword=password bitnami/memcached
```

The above command sets the Memcached admin account username and password to `user` and `password` respectively.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install my-release -f values.yaml bitnami/memcached
```

> **Tip**: You can use the default [values.yaml](values.yaml)
