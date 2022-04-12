# Helm (v3)Charts for KubeGems Application Stores

这个仓库主要为 **KubeGems应用商店** 提供基于 Helm(v3) charts 的托管，这里面大部分都来源于 Bitnami、helm offical以及部分自写的 charts 包。由于 KubeGems2.3（包含）以下的版本不支持在界面上传自定义Charts，所以需要将本仓库构建出镜像，并提交charts-updater任务触发应用商店更新。

## ChartMuseum

ChartMuseum是一个用Go（Golang）编写的开源Helm Chart Repository服务器，支持云存储后端，包括Google云存储，Amazon S3，Microsoft Azure Blob存储，阿里云OSS存储，Openstack对象存储和Oracle云基础架构对象存储.

[chartmusem官方文档]( https://chartmuseum.com/docs/)

## 操作说明

### Charts打包

```
$ make package
```

### 构建 docker 镜像

```
$ make build
```
### 更新应用商店

```
$ make apply
```
### 常用命令

### helm

- 查看所有charts

```
$helm search repo xxx
```

- 下载依赖到charts目录
  
```
$ helm dependency update
```

- helm 本地渲染模板
  
```
$ helm template .
```

- 生成charts索引文件index.yaml

```
 helm repo index [DIR] [flags]
```

## JsonSchema文件

### 利用jsonSchema文件自动渲染前端表单组件

关于chart模式文件values.schema.json, 请参考: https://helm.sh/zh/docs/topics/charts/

KubeGems应用商店部署页面的中间件表单, 采用`values.schema.json`文件进行渲染, 针对滑块组件和嵌套依赖组件的渲染, 通过自定义的字段render和hidden实现,下面是Kafka的参考values.schema.json

```json
{
  "$schema": "http://json-schema.org/schema#",
  "type": "object",
  "properties": {
    "nameOverride": {
      "type": "string",
      "title": "nameOverride(Kafka实例名称)",
      "description": "Kafka部署到Kubernetes中的Workerload名称",
      "form": true
    },
    "fullnameOverride": {
      "type": "string",
      "title": "fullnameOverride(Kafka服务名称)",
      "description": "Kafka部署到Kubernetes中的Service名称",
      "form": true
    },
    "replicaCount": {
      "type": "integer",
      "title": "replicaCount(Kafka副本数)",
      "form": true,
      "default": 1
    },
    "persistence": {
      "type": "object",
      "form": true,
      "title": "PersistetVolume设置",
      "properties": {
        "enabled": {
          "type": "boolean",
          "title": "enabled(启用PersistentVolumeClaim)",
          "form": true,
          "description": "为Kafka集群提供持久化存储"
        },
        "size": {
          "type": "string",
          "title": "size(PersistentVolume空间)",
          "form": true,
          "render": "slider",
          "sliderMin": 1,
          "sliderMax": 100,
          "sliderUnit": "Gi",
          "description": "Kafka持久化磁盘空间容量，默认Gi",
          "default": "10Gi",
          "hidden": {
            "condition": false,
            "value": "enabled"
          }
        },
        "storageClass": {
          "type": "string",
          "title": "StorageClass名称",
          "form": true,
          "description": "PersistentVolume使用的存储声明",
          "hidden": {
            "condition": false,
            "value": "enabled"
          }
        }
      }
    },
    "zookeeper": {
      "type": "object",
      "form": true,
      "title": "Zookeeper设置",
      "properties": {
        "enabled": {
          "type": "boolean",
          "title": "enabled(启用Zookeeper服务)",
          "form": true,
          "default": true,
          "description": "创建一个Zookeeper集群"
        },
        "replicaCount": {
          "type": "integer",
          "title": "replicaCount(Zookeeper集群副本数)",
          "form": true,
          "default": 1,
          "hidden": {
            "condition": false,
            "value": "enabled"
          }
        },
        "persistence": {
          "type": "object",
          "form": true,
          "title": "PersistentVolume设置",
          "hidden": {
            "condition": false,
            "value": "enabled"
          },
          "properties": {
            "enabled": {
              "type": "boolean",
              "title": "enabled(启用PersistentVolumeCliam)",
              "form": true,
              "description": "为Zookeeper机器提供持久化存储"
            },
            "size": {
              "type": "string",
              "title": "size(PersistentVolume空间)",
              "form": true,
              "render": "slider",
              "sliderMin": 1,
              "sliderMax": 100,
              "sliderUnit": "Gi",
              "default": "2Gi",
              "description": "Zookeeper持久化磁盘空间容量,默认Gi",
              "hidden": {
                "condition": false,
                "value": "enabled"
              }
            },
            "storageClass": {
              "type": "string",
              "title": "StorageClass名称 ",
              "form": true,
              "description": "PersistentVolume使用的存储声明",
              "hidden": {
                "condition": false,
                "value": "enabled"
              }
            }
          }
        }
      }
    }
  }
}
```

### 字段说明

官方文档请参考[理解JSON Schema](https://json-schema.org/understanding-json-schema/)

- type: 字段类型, 如果为object则表示有子属性(字段)
- title: 标题, 对应表单标签信息
- form: 表单是否开启, 如果字段没有该字段或为false, 表示不渲染该字段
- default: 默认值

### 滑块表单

- render: 渲染类型, slider表示滑块, textArea表示文本框
- sliderMin: 滑块最小值
- sliderMax: 滑块最大值
- sliderUnit: 滑块单位

### 表单关联

通过hidden字段实现, 比如要实现打开zookeeper开关, 其子表单才显示出来的效果, 通过value中的值enabled与hidden父级字段同级的enabled字段关联实现联动, 比如以上Json案例中的persistence对象中的enabed字段为打开, 则size和storageClass中的hidden.value由于依赖该enabled字段, 所以默认打开, 反之亦然, condition字段暂时没有使用

注意事项: 暂时不支持跨父节点关联

### 整数integer

如果字段类型是整数integer, 则必须添加最小值(sliderMin)/最大值(sliderMax), 前端会根据该范围做表单校验, 比如

```json
    "replicaCount": {
      "type": "integer",
      "title": "replicaCount(emqx副本数)",
      "default": "3",
      "form": true,
      "order": 3,
      "sliderMin": 1,
      "sliderMax": 10
    },
```

## 常用链接

- Helm3 ArtifactHub (https://artifacthub.io)

- Mware bitnami (https://bitnami.com/)
