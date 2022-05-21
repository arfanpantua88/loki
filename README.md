# Installing and configuring Loki

## Prerequisite
### When we are using k8s service provided by AWS we can use serviceaccount to access all service in AWS environment without need either to put ACCESS ID or ACCESS SECRET KEY

## Create namespace
- `kubectl create namespace loki`

- Running account-service.sh

### Current running version
#### Helm chart 2.9.1 App 2.4.2
#### Helm repo https://grafana.github.io/helm-charts

## Migration

### Prerequisite
#### - `kubectl scale statefulsets loki --replicas=0 -n loki #this will give chance to pod ubuntu to take over the pvc` #this will give chance to pod ubuntu to take over the pvc`
#### - `kubectl apply -f .\ubuntu-pod.yaml -n loki`

#### *Copy file from local into pod. This script purpose is to transfer existing chunk data to object storage (S3)*

## Create a bucket in s3
#### - `kubectl cp ./script.py <loki-namespace>/<ubuntu-pod>:/home/`
#### - `kubectl cp ./transfer.sh <loki-namespace>/<ubuntu-pod>:/home/`

## Login to pod
#### - `kubectl exec -it <ubuntu-pod> -n <namespace> -c <container> bash`
#### &emsp;&emsp;- `chmod +x /home/transfer.sh`
#### &emsp;&emsp;     - `/home/transfer.sh`

## Upgrade Helm
#### - `helm delete loki -n loki`
#### - `helm upgrade --install --version 2.10.3 loki --namespace loki grafana/loki --values .\storage-config-aws.yaml`

## Rollback

#### - `helm delete loki -n loki`
#### - `helm upgrade --install --version 2.9.1 loki --namespace loki grafana/loki --values .\loki_values_yaml.yaml`