#!/bin/bash



cd $PROJECT_HOME_DIR #change into project home directory.


gcloud config set project $GCLOUD_PROJECT_ID # set the default project for docker and google

# if artifact repository does not exists! create one. (required by google cloud artifact)
if ! gcloud artifacts repositories describe $DOCKER_REPOSITORY_NAME \
    --location=$GCLOUD_APP_REGION \
    --project=$GCLOUD_PROJECT_ID &>/dev/null; then
    gcloud artifacts repositories create $DOCKER_REPOSITORY_NAME \
        --location=$GCLOUD_APP_REGION \
        --repository-format=docker \
        --project=$GCLOUD_PROJECT_ID
fi

gcloud auth configure-docker $DOCKER_REGISTRY_HOST --quiet --project=$GCLOUD_PROJECT_ID # configure docker to use google cloud artifact 
docker image rm $DOCKER_TARGET_IMAGE # remove if there is already image with the name
docker build -t $DOCKER_TARGET_IMAGE . # build the image locally
docker push $DOCKER_TARGET_IMAGE # push the image to google artifact registry
# deploy it on google cloud run
gcloud run deploy $GCLOUD_APP_SERVICE_NAME \
         --image=$DOCKER_TARGET_IMAGE \
         --platform=managed \
         --region=$GCLOUD_APP_REGION \
         --allow-unauthenticated \
         --max-instances=$MAX_INSTANCES \
         --min-instances=$MIN_INSTANCES \
         --memory=$PER_INSTANCE_MEMORY \
         --cpu=$PER_INSTANCE_CPU \
         --quiet \
         --project=$GCLOUD_PROJECT_ID
docker image rm $DOCKER_TARGET_IMAGE # delete local docker image to save disk space.
echo "COMPLETED DEPLOYMENT"
# gcloud artifacts docker images delete $DOCKER_TARGET_IMAGE --quiet # optional, if you want to delete image in artifact.