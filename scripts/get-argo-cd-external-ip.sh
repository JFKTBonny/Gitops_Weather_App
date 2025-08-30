#!/bin/bash

SERVICE_NAME="argocd-server"
NAMESPACE="argocd"

EXTERNAL_IP=""

# # #  Loop until the external IP is assigned and DNS resolves
while true; do
    # # Get the hostname from the service
    EXTERNAL_IP=$(kubectl get service "$SERVICE_NAME" -n "$NAMESPACE" -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

    if [ -n "$EXTERNAL_IP" ]; then
        # Check if DNS resolves
        if nslookup "$EXTERNAL_IP" >/dev/null 2>&1; then
            echo "External IP assigned and DNS resolved: $EXTERNAL_IP"
            break
        else
            echo "Hostname assigned but DNS not yet resolvable. Waiting..."
        fi
    else
        echo "Waiting for external IP..."
    fi

    sleep 10
done
