#!/bin/bash
# Inspired by https://github.com/honestbee/drone-kubernetes/blob/master/update.sh

doFinish(){
  # Run kubectl command
  if [[ ! -z ${PLUGIN_KUBECTL} ]]; then
    kubectl ${PLUGIN_KUBECTL}
  fi

  # Run helm command
  if [[ ! -z ${PLUGIN_HELM} ]]; then
    helm ${PLUGIN_HELM}
  fi
  exit 0
}

if [[ ! -z ${KUBECTL_CONFIG} ]]; then
  mkdir ~/.kube
  touch ~/.kube/config
  echo ${KUBECTL_CONFIG} > ~/.kube/config
  doFinish
fi

if [[ ! -z ${KUBERNETES_TOKEN} ]]; then
  KUBERNETES_TOKEN=$KUBERNETES_TOKEN
fi

if [[ ! -z ${KUBERNETES_SERVER} ]]; then
  KUBERNETES_SERVER=$KUBERNETES_SERVER
fi

if [[ ! -z ${KUBERNETES_CERT} ]]; then
  KUBERNETES_CERT=${KUBERNETES_CERT}
fi

kubectl config set-credentials ${USER} --token=${KUBERNETES_TOKEN}
if [[ ! -z ${KUBERNETES_CERT} ]]; then
  # echo ${KUBERNETES_CERT} | base64 -d >ca.crt
  echo ${KUBERNETES_CERT} >ca.crt
  kubectl config set-cluster default --server=${KUBERNETES_SERVER} --certificate-authority=ca.crt
else
  echo "WARNING: Using insecure connection to cluster"
  kubectl config set-cluster default --server=${KUBERNETES_SERVER} --insecure-skip-tls-verify=true
fi

kubectl config set-context default --cluster=default --user=${USER}
kubectl config use-context default
doFinish

