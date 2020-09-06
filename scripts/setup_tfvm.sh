set -e

gcloud config set project fast-circle-288706
gcloud config set compute/zone europe-west4-c

gcloud compute instances create gpu-instance-deeplab \
    --machine-type n1-standard-2 --zone europe-west4-c \
    --scopes=storage-full --boot-disk-size=50GB \
    --image-family tf2-latest-cpu --image-project deeplearning-platform-release \
    --maintenance-policy TERMINATE --restart-on-failure \

gcloud compute firewall-rules create streamlit --allow tcp:8501 --source-tags="gpu-instance-deeplab" --source-ranges=0.0.0.0/0 --description="la"
