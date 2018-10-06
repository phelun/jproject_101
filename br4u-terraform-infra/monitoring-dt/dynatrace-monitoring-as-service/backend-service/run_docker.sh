#!/bin/bash
# The backend service runs as a single instance and is bound to port 9000
INSTANCE_NAME=backend-service-instance
sudo docker run --name $INSTANCE_NAME -p 9000:80 -e PROCESS_NAME=BACKEND_$Environment -e BUILD_NUMBER=$BUILD_NUMBER -e DT_CUSTOM_PROP="SERVICE_TYPE=BACKEND ENVIRONMENT=$Environment" -d backend-service:latest