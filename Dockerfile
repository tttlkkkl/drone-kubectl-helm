FROM alpine:3.12
LABEL maintainer="lihua <tttlkkkl@aliyun.com>"

ENV KUBERNETES_TOKEN=
ENV KUBERNETES_CERT=
ENV KUBERNETES_SERVER=
ENV PLUGIN_KUBECTL="version"
ENV PLUGIN_HELM=""
ENV USER="default"
ENV KUBECTL_CONFIG=
RUN echo 'https://mirrors.aliyun.com/alpine/v3.12/main/' > /etc/apk/repositories && \
    echo 'https://mirrors.aliyun.com/alpine/v3.12/community/' >> /etc/apk/repositories
RUN apk add --update ca-certificates \
  && apk add --no-cache bash aws-cli
COPY ["helm","kubectl","/usr/local/bin/"]
RUN chmod +x /usr/local/bin/helm \
  && chmod +x /usr/local/bin/kubectl
  
# RUN helm repo add stable https://charts.helm.sh/stable

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
