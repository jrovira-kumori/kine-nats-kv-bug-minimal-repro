#!/usr/bin/env bash
cd $(dirname "$0")
NAME="${NAME:-kind}"

cat kind-cluster.yaml.template | envsubst > kind-cluster.yaml

echo 
echo 
echo Cluster creation will time out. 
echo You should cancel it during the \"Starting control-plane\" phase.
echo 
echo 

trap "exit 0" SIGINT
kind create cluster --config kind-cluster.yaml --name "$NAME" --retain
