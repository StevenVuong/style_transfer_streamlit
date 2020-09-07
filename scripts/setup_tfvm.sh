set -e
# https://towardsdatascience.com/deploy-machine-learning-app-built-using-streamlit-and-pycaret-on-google-kubernetes-engine-fd7e393d99cb
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

gcloud config list

gcloud auth login
gcloud config set core/project ${PROJECT_ID}
gcloud config set compute/zone ${GCP_ZONE}
gcloud config set container/cluster ${CLUSTER_NAME}
gcloud container clusters get-credentials ${CLUSTER_NAME}

gcloud projects add-iam-policy-binding "fast-circle-288706" --member="steven.vuong@foundersfactory.co" --role="roles/owner"


gcloud builds submit --tag gcr.io/"fast-circle-288706"/app

gcloud container clusters create ${CLUSTER_NAME} --num-nodes=2

PROJECT_ID="fast-circle-288706"
kubectl create deployment app --image=gcr.io/${PROJECT_ID}/app:v1
kubectl expose deployment app --type=LoadBalancer --port 80 --target-port 8501
kubectl get service