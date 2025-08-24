#!/bin/bash

# Define the service and namespace
SERVICE_NAME="argocd-server"
NAMESPACE="argocd"

# Initialize external IP
EXTERNAL_IP=""

# Loop until the external IP is assigned
while [ -z "$EXTERNAL_IP" ]; do
    echo "Waiting for external IP..."
    EXTERNAL_IP=$(kubectl get service "$SERVICE_NAME" -n "$NAMESPACE" | tail -2 | head -1 | awk '{print $4}')
    # Wait for 10 seconds before checking again
    sleep 10
done

echo "External IP assigned: $EXTERNAL_IP"