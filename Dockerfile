FROM alpine:latest
LABEL maintainer="lihua <tttlkkkl@aliyun.com>"

ENV HELM_VERSION="v2.14.3"
ENV KUBECTL_VERSION="v1.15.3"
ENV KUBERNETES_TOKEN=
ENV KUBERNETES_CERT=
ENV KUBERNETES_SERVER=
ENV PLUGIN_KUBECTL="version"
ENV PLUGIN_HELM=""
ENV USER="default"
ENV KUBECTL_CONFIG=
RUN \
  apk add --update ca-certificates && \
  apk add -t deps curl && \
  apk add bash
ADD https://get.helm.sh/helm-v3.5.2-linux-arm64.tar.gz /app/helm/
RUN mv /app/helm/helm /usr/local/bin/helm && \
    rm -rf /app

RUN \
  curl -Lo /usr/local/bin/kubectl \
    curl -LO https://dl.k8s.io/release/v1.18.8/bin/linux/amd64/kubectl && \
  chmod +x /usr/local/bin/kubectl && \
  apk del --purge deps && \
  rm /var/cache/apk/* 
  
RUN helm init --client-only --stable-repo-url=https://charts.helm.sh/stable

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
