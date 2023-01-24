#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/"

SERVICE_FOLDER_NAME="python-flask"
SERVICE_FOLDER="${SCRIPT_DIR}/../${SERVICE_FOLDER_NAME}"
SERVICE_DOCKER_BUILD_CONTEXT="${SERVICE_FOLDER}/"
SERVICE_DOCKER_FILE="${SERVICE_FOLDER}/docker/Dockerfile"

# leading . is necessary to export GENERATED_IMAGE
. ${SCRIPT_DIR}/generic-docker-build.sh \
  --docker-context-folder ${SERVICE_DOCKER_BUILD_CONTEXT} \
  --dockerfile ${SERVICE_DOCKER_FILE} \
  --dockerImageName ${SERVICE_FOLDER_NAME}

echo "MY_IMAGE_VERSION_TAG=$GENERATED_IMAGE"
. ${SCRIPT_DIR}/generic-k8s-kustomize-build.sh \
  --serviceFolder ../python-flask \
  --dockerImageName "${GENERATED_IMAGE}"