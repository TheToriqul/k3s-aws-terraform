#!/bin/bash
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --tls-san $(curl -s http://169.254.169.254/latest/meta-data/public-ipv4) --write-kubeconfig-mode 644" sh -

# Install NGINX Ingress Controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.0/deploy/static/provider/aws/deploy.yaml
