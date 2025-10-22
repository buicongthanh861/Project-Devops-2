#!/bin/sh
BASE_DIR=~/kubernets
cd $BASE_DIR

[ -f "namespace.yaml" ] && kubectl apply -f namespace.yaml
[ -f "secret.yaml" ] && kubectl apply -f secret.yaml
[ -f "deployment.yaml" ] && kubectl apply -f deployment.yaml
[ -f "service.yaml" ] && kubectl apply -f service.yaml
