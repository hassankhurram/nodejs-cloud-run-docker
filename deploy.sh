#!/bin/bash
GCLOUD_PROJECT_ID="my-project"
gcloud builds submit --config=cloudbuild.yaml --substitutions=_PROJECT_ID=$GCLOUD_PROJECT_ID --project=$GCLOUD_PROJECT_ID