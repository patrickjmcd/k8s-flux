source env.vars

kubectl create namespace flux-system

kubectl apply --kustomize=../cluster/base/flux-system
kubectl apply --kustomize=../cluster/base/flux-system
