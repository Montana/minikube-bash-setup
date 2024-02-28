#!/bin/bash

set -e

minikube start

if [[ $(minikube status --format "{{.Host}}") == "Running" ]]; then
  echo "Minikube is running"
else
  echo "Minikube failed to start"
  exit 1
fi

kubectl apply -f ./nginx-deployment.yaml

kubectl get deployments
kubectl get pods

SECONDS=0
TIMEOUT=120
ALL_PODS_RUNNING=false

echo "Waiting for pods to be in the Running state..."

while [[ $SECONDS -lt $TIMEOUT ]]; do

  PODS_STATUS=$(kubectl get pods --no-headers -o custom-columns=":status.phase")

  ALL_RUNNING=true
  for status in $PODS_STATUS; do
    if [[ $status != "Running" ]]; then
      ALL_RUNNING=false
      break
    fi
  done

  if [[ $ALL_RUNNING == true ]]; then
    ALL_PODS_RUNNING=true
    break
  fi

  sleep 5
done

if [[ $ALL_PODS_RUNNING == true ]]; then
  echo "All pods are running."
else
  echo "Timed out waiting for pods to be running."
  exit 1
fi
