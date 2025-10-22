#!/bin/sh
BASE_DIR=/home/ubuntu/kubernets

kubectl apply -f $BASE_DIR/namespace.yaml
kubectl apply -f $BASE_DIR/secret.yaml
kubectl apply -f $BASE_DIR/deployment.yaml
kubectl apply -f $BASE_DIR/service.yaml
