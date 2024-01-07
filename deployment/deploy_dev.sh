#!/bin/bash

# Environment variables (must change for initial setup)!!!
export DEPLOYMENT_ENVIRONMENT="dev" # The deployment environment (e.g., dev, prod)
export MAX_IMAGES_IN_REPOSITORY=0  # Maximum number of images to keep in the repository
export PROJECT_HOME_DIR="~/projects/helloworld"  # Project's home directory
export GCLOUD_PROJECT_ID="gcp-test-project"  # Google Cloud Project ID
export GCLOUD_APP_REGION="asia-southeast2"  # Google Cloud region
export GCLOUD_APP_SERVICE_NAME="helloworld"  # Name of the application service

# optionally you can change these:

export DOCKER_IMAGE_VERSION=$(date +"%Y%m%d-%H%M%S")  # Auto-generate date-time as version
export DOCKER_REPOSITORY_NAME="$GCLOUD_APP_SERVICE_NAME"  # Docker repository name
export DOCKER_IMAGE_NAME="$GCLOUD_APP_SERVICE_NAME-$DEPLOYMENT_ENVIRONMENT"  # Docker image name
export MAX_INSTANCES=5  # Maximum number of instances for the application
export MIN_INSTANCES=0  # Minimum number of instances for the application
export PER_INSTANCE_CPU=1  # CPU allocated per instance
export PER_INSTANCE_MEMORY="512Mi"  # Memory allocated per instance

# Do not touch the following lines unless you change main.sh as well.


export DOCKER_REGISTRY_HOST="$GCLOUD_APP_REGION-docker.pkg.dev"  # Docker registry host
export REPOSITORY_PATH="$DOCKER_REGISTRY_HOST/$GCLOUD_PROJECT_ID/$DOCKER_REPOSITORY_NAME"  # Full repository path
export IMAGE_PATH="$REPOSITORY_PATH/$DOCKER_IMAGE_NAME"  # Full image path
export DOCKER_TARGET_IMAGE="$IMAGE_PATH:version-$DOCKER_IMAGE_VERSION"  # Docker target image

# Run the main script
bash main.sh
