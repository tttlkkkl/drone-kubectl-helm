FROM alpine:latest
LABEL maintainer="lihua <tttlkkkl@aliyun.com>"

ENV HELM_VERSION="v2.14.3"
ENV KUBECTL_VERSION="v1.15.3"
ENV KUBERNETES_TOKEN=
ENV KUBERNETES_CERT=
ENV KUBERNETES_SERVER=
ENV PLUGIN_KUBECTL="version"
ENV PLUGIN_HELM="init --client-only --stable-repo-url=http://mirror.azure.cn/kubernetes/charts/"
ENV USER="default"
ENV KUBECTL_CONFIG=
RUN \
  apk add --update ca-certificates && \
  apk add -t deps curl && \
  apk add bash

RUN \
  curl -Lo /tmp/helm.tar.gz \
    https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz && \
  tar -xvf /tmp/helm.tar.gz -C /tmp && \
  mv /tmp/linux-amd64/helm /usr/local/bin && \
  rm -rf /tmp/*

RUN \
  curl -Lo /usr/local/bin/kubectl \
    https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
  chmod +x /usr/local/bin/kubectl && \
  apk del --purge deps && \
  rm /var/cache/apk/*

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
