FROM alpine:latest
LABEL maintainer="lihua <tttlkkkl@aliyun.com>"

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
COPY helm /usr/local/bin/helm

RUN chmod +x /usr/local/bin/helm \
  && curl -Lo /usr/local/bin/kubectl https://dl.k8s.io/release/v1.18.8/bin/linux/amd64/kubectl \
  && chmod +x /usr/local/bin/kubectl \
  && apk del --purge deps \
  && rm /var/cache/apk/* 
  
RUN helm init --client-only --stable-repo-url=https://charts.helm.sh/stable

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
