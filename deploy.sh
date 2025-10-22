#!/bin/sh
BASE_DIR=$(pwd)

# Xóa các resource cũ (nếu có)
kubectl delete -f "$BASE_DIR/namespace.yaml" --ignore-not-found
kubectl delete -f "$BASE_DIR/secret.yaml" --ignore-not-found
kubectl delete -f "$BASE_DIR/service.yaml" --ignore-not-found

# Apply lại các resource mới
kubectl apply -f "$BASE_DIR/namespace.yaml"
kubectl apply -f "$BASE_DIR/secret.yaml"
kubectl apply -f "$BASE_DIR/service.yaml"