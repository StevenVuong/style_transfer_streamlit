set -e

gcloud config set project fast-circle-288706
gcloud config set compute/zone europe-west4-c

gcloud compute instances create gpu-instance-deeplab \
    --machine-type n1-standard-2 --zone europe-west4-c \
    --scopes=storage-full --boot-disk-size=50GB \
    --image-family tf2-latest-cpu --image-project deeplearning-platform-release \
    --maintenance-policy TERMINATE --restart-on-failure \

gcloud compute firewall-rules create streamlit --allow tcp:8501 --source-tags="gpu-instance-deeplab" --source-ranges=0.0.0.0/0 --description="la"

PROJECT_ID="fast-circle-288706"
GCP_ZONE="europe-west4-c"
CLUSTER_NAME="streamlit"

gcloud auth login
gcloud config set core/project ${PROJECT_ID}
gcloud config set compute/zone ${GCP_ZONE}
gcloud config set container/cluster ${CLUSTER_NAME}
gcloud container clusters get-credentials ${CLUSTER_NAME}
