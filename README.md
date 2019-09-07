# drone-kubectl-helm
Drone kubectl and helm plugin.
Set Up a Drone CI/CD pipeline with Kubernetes https://akomljen.com/set-up-a-drone-ci-cd-pipeline-with-kubernetes

- 可以通过环境变量:`HELM_VERSION` 和 `KUBECTL_VERSION` 重新指定客户端版本
- 当设置了`KUBECTL_CONFIG`环境变量，将直接将其写入到`~/.kube/config`然后退出。脚本中会对`KUBECTL_CONFIG`在进行一次base64解码。如果使用k8s secret 存储，意味着你要对原值进行两次base64编码。
- 通过token访问集群，你需要配置以下三个环境变量：
```bash
KUBERNETES_TOKEN # token 必须
KUBERNETES_CERT # 如果集群允许，证书留空将使用不安全的连接
KUBERNETES_SERVER # api server 地址，必须。
```
- 通过设置环境变量`PLUGIN_KUBECTL`的值指定初始化完成后运行的 kubectl 命令。
- 通过设置环境变量`PLUGIN_HELM`的值指定初始化完成后运行的 helm 命令。