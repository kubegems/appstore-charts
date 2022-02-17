# RabbitMQ

[RabbitMQ](https://www.rabbitmq.com/)是一款广泛部署的开源消息代理组件

## 安装

```bash
$ helm install stable/rabbitmq
```

## 需求

- Kubernetes 1.8+
- PV provisioner support in the underlying infrastructure

## 参数

| Parameter                            | Description                                      | Default                                                 |
| ------------------------------------ | ------------------------------------------------ | ------------------------------------------------------- |
| `global.imageRegistry`               | Global Docker image registry                     | `nil`                                                   |
| `global.imagePullSecrets`            | Global Docker registry secret names as an array  | `[]` (does not add image pull secrets to deployed pods) |
| `global.storageClass`                     | Global storage class for dynamic provisioning                                               | `nil`                                                        |
| `image.registry`                     | Rabbitmq Image registry                          | `docker.io`                                             |
| `image.repository`                   | Rabbitmq Image name                              | `bitnami/rabbitmq`                                      |
| `image.tag`                          | Rabbitmq Image tag                               | `{TAG_NAME}`                                            |
| `image.pullPolicy`                   | Image pull policy                                | `IfNotPresent`                                          |
| `image.pullSecrets`                  | Specify docker-registry secret names as an array | `nil`                                                   |
| `image.debug`                        | Specify if debug values should be set            | `false`                                                 |
| `nameOverride`                       | String to partially override rabbitmq.fullname template with a string (will prepend the release name) | `nil` |
| `fullnameOverride`                   | String to fully override rabbitmq.fullname template with a string                                     | `nil` |
| `rbacEnabled`                        | Specify if rbac is enabled in your cluster       | `true`                                                  |
| `podManagementPolicy`                | Pod management policy                            | `OrderedReady`                                          |
| `rabbitmq.username`                  | RabbitMQ application username                    | `user`                                                  |
| `rabbitmq.password`                  | RabbitMQ application password                    | _random 10 character long alphanumeric string_          |
| `rabbitmq.existingPasswordSecret`    | Existing secret with RabbitMQ credentials        | `nil`                                                   |
| `rabbitmq.erlangCookie`              | Erlang cookie                                    | _random 32 character long alphanumeric string_          |
| `rabbitmq.existingErlangSecret`      | Existing secret with RabbitMQ Erlang cookie      | `nil`                                                   |
| `rabbitmq.plugins`                   | List of plugins to enable                        | `rabbitmq_management rabbitmq_peer_discovery_k8s`       |
| `rabbitmq.extraPlugins`              | Extra plugings to enable                         | `nil`                                                   |
| `rabbitmq.clustering.address_type`   | Switch clustering mode                           | `ip` or `hostname`                                      |
| `rabbitmq.clustering.k8s_domain`     | Customize internal k8s cluster domain            | `cluster.local`                                         |
| `rabbitmq.logs`                      | Value for the RABBITMQ_LOGS environment variable | `-`                                                     |
| `rabbitmq.setUlimitNofiles`          | Specify if max file descriptor limit should be set | `true`                                                |
| `rabbitmq.ulimitNofiles`             | Max File Descriptor limit                        | `65536`                                                 |
| `rabbitmq.maxAvailableSchedulers`    | RabbitMQ maximum available scheduler threads     | `2`                                                     |
| `rabbitmq.onlineSchedulers`          | RabbitMQ online scheduler threads                | `1`                                                     |
| `rabbitmq.env`                       | RabbitMQ [environment variables](https://www.rabbitmq.com/configure.html#customise-environment) | `{}`     |
| `rabbitmq.configuration`             | Required cluster configuration                   | See values.yaml                                         |
| `rabbitmq.extraConfiguration`        | Extra configuration to add to rabbitmq.conf      | See values.yaml                                         |
| `rabbitmq.advancedConfiguration`     | Extra configuration (in classic format) to add to advanced.config    | See values.yaml                                         |
| `rabbitmq.tls.enabled`                  | Enable TLS support to rabbitmq |   | `false`                     |
| `rabbitmq.tls.failIfNoPeerCert`     | When set to true, TLS connection will be rejected if client fails to provide a certificate  | `true` |
| `rabbitmq.tls.sslOptionsVerify`     | `verify_peer`  | Should [peer verification](https://www.rabbitmq.com/ssl.html#peer-verification) be enabled? |
| `rabbitmq.tls.caCertificate`     | Ca certificate  | Certificate Authority (CA) bundle content |
| `rabbitmq.tls.serverCertificate`     | Server certificate  | Server certificate content |
| `rabbitmq.tls.serverKey`     | Server Key  | Server private key content |
| `rabbitmq.tls.existingSecret`                                   | Existing secret with certificate content to rabbitmq credentials                                                                                                                  | `nil`                                                    |
| `service.type`                       | Kubernetes Service type                          | `ClusterIP`                                             |
| `service.port`                       | Amqp port                                        | `5672`                                                  |
| `service.tlsPort`                   | Amqp TLS port                                    | `5671`                                                  |
| `service.distPort`                   | Erlang distribution server port                  | `25672`                                                 |
| `service.nodePort`                   | Node port override, if serviceType NodePort      | _random available between 30000-32767_                  |
| `service.nodeTlsPort`                | Node port override, if serviceType NodePort      | _random available between 30000-32767_                  |
| `service.managerPort`                | RabbitMQ Manager port                            | `15672`                                                 |
| `persistence.enabled`                | Use a PVC to persist data                        | `true`                                                  |
| `service.annotations`                | service annotations as an array                  | []                                                      |
| `schedulerName`                      | Name of the k8s service (other than default)     | `nil`                                                   |
| `persistence.storageClass`           | Storage class of backing PVC                     | `nil` (uses alpha storage class annotation)             |
| `persistence.existingClaim`          | RabbitMQ data Persistent Volume existing claim name, evaluated as a template |  ""          |
| `persistence.accessMode`             | Use volume as ReadOnly or ReadWrite              | `ReadWriteOnce`                                         |
| `persistence.size`                   | Size of data volume                              | `8Gi`                                                   |
| `persistence.path`                   | Mount path of the data volume                    | `/opt/bitnami/rabbitmq/var/lib/rabbitmq`                |
| `securityContext.enabled`            | Enable security context                          | `true`                                                  |
| `securityContext.fsGroup`            | Group ID for the container                       | `1001`                                                  |
| `securityContext.runAsUser`          | User ID for the container                        | `1001`                                                  |
| `resources`                          | resource needs and limits to apply to the pod    | {}                                                      |
| `replicas`                           | Replica count                                    | `1`                                                     |
| `priorityClassName`                  | Pod priority class name                          | ``                                                      |
| `nodeSelector`                       | Node labels for pod assignment                   | {}                                                      |
| `affinity`                           | Affinity settings for pod assignment             | {}                                                      |
| `tolerations`                        | Toleration labels for pod assignment             | []                                                      |
| `updateStrategy`                     | Statefulset update strategy policy               | `RollingUpdate`                                         |
| `ingress.enabled`                    | Enable ingress resource for Management console   | `false`                                                 |
| `ingress.hostName`                   | Hostname to your RabbitMQ installation           | `nil`                                                   |
| `ingress.path`                       | Path within the url structure                    | `/`                                                     |
| `ingress.tls`                        | enable ingress with tls                          | `false`                                                 |
| `ingress.tlsSecret`                  | tls type secret to be used                       | `myTlsSecret`                                           |
| `ingress.annotations`                | ingress annotations as an array                  | []                                                      |
| `livenessProbe.enabled`              | would you like a livenessProbed to be enabled    | `true`                                                  |
| `livenessProbe.initialDelaySeconds`  | number of seconds                                | 120                                                     |
| `livenessProbe.timeoutSeconds`       | number of seconds                                | 20                                                      |
| `livenessProbe.periodSeconds`        | number of seconds                                | 30                                                      |
| `livenessProbe.failureThreshold`     | number of failures                               | 6                                                       |
| `livenessProbe.successThreshold`     | number of successes                              | 1                                                       |
| `readinessProbe.enabled`             | would you like a readinessProbe to be enabled    | `true`                                                  |
| `readinessProbe.initialDelaySeconds` | number of seconds                                | 10                                                      |
| `readinessProbe.timeoutSeconds`      | number of seconds                                | 20                                                      |
| `readinessProbe.periodSeconds`       | number of seconds                                | 30                                                      |
| `readinessProbe.failureThreshold`    | number of failures                               | 3                                                       |
| `readinessProbe.successThreshold`    | number of successes                              | 1                                                       |
| `metrics.enabled`                    | Start a side-car prometheus exporter             | `false`                                                 |
| `metrics.image.registry`             | Exporter image registry                          | `docker.io`                                             |
| `metrics.image.repository`           | Exporter image name                              | `bitnami/rabbitmq-exporter`                             |
| `metrics.image.tag`                  | Exporter image tag                               | `{TAG_NAME}`                                            |
| `metrics.image.pullPolicy`           | Exporter image pull policy                       | `IfNotPresent`                                          |
| `metrics.port`                       | Prometheus metrics exporter port                 | `9419`                                                  |
| `metrics.env`                        | Exporter [configuration environment variables](https://github.com/kbudde/rabbitmq_exporter#configuration) | `{}` |
| `metrics.resources`                  | Exporter resource requests/limit                 | `nil`                                                   |
| `metrics.capabilities`               | Exporter: Comma-separated list of extended [scraping capabilities supported by the target RabbitMQ server](https://github.com/kbudde/rabbitmq_exporter#extended-rabbitmq-capabilities) | `bert,no_sort` |
| `podLabels`                          | Additional labels for the statefulset pod(s).    | {}                                                      |
| `volumePermissions.enabled`         | Enable init container that changes volume permissions in the data directory (for cases where the default k8s `runAsUser` and `fsUser` values do not work)                                                               | `false`                                          |
| `volumePermissions.image.registry`         | Init container volume-permissions image registry                                                               | `docker.io`                                          |
| `volumePermissions.image.repository`       | Init container volume-permissions image name                                                                   | `bitnami/minideb`                                    |
| `volumePermissions.image.tag`              | Init container volume-permissions image tag                                                                    | `stretch`                                             |
| `volumePermissions.image.pullPolicy`       | Init container volume-permissions image pull policy                                                            | `Always`                                             |
| `volumePermissions.resources`                  | Init container resource requests/limit                 | `nil`                                                   |
| `forceBoot.enabled`         | Executes 'rabbitmqctl force_boot' to force boot cluster shut down unexpectedly in an unknown order. Use it only if you prefer availability over integrity.                                                               | `false`                                          |

The above parameters map to the env variables defined in [bitnami/rabbitmq](http://github.com/bitnami/bitnami-docker-rabbitmq). For more information please refer to the [bitnami/rabbitmq](http://github.com/bitnami/bitnami-docker-rabbitmq) image documentation.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install --name my-release \
  --set rabbitmq.username=admin,rabbitmq.password=secretpassword,rabbitmq.erlangCookie=secretcookie \
    stable/rabbitmq
```

The above command sets the RabbitMQ admin username and password to `admin` and `secretpassword` respectively. Additionally the secure erlang cookie is set to `secretcookie`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml stable/rabbitmq
```

> **Tip**: You can use the default [values.yaml](values.yaml)


