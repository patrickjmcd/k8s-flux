source env.vars

kubectl create namespace flux-system

gpg --export-secret-keys --armor "${FLUX_KEY_FP}" |
kubectl create secret generic sops-gpg \
    --namespace=flux-system \
    --from-file=sops.asc=/dev/stdin

rm -rf ../cluster/base/cluster-secrets.yaml
rm -rf ../cluster/base/cluster-settings.yaml
rm -rf ../cluster/base/flux-system/gotk-sync.yaml
rm -rf ../cluster/core/cert-manager/secret.enc.yaml

envsubst < ../tmpl/cluster-secrets.yaml > ../cluster/base/cluster-secrets.yaml
envsubst < ../tmpl/cluster-settings.yaml > ../cluster/base/cluster-settings.yaml
envsubst < ../tmpl/gotk-sync.yaml > ../cluster/base/flux-system/gotk-sync.yaml
envsubst < ../tmpl/cloudflare.secret.enc.yaml > ../cluster/core/cert-manager/secret.enc.yaml

sops --encrypt --in-place ../cluster/base/cluster-secrets.yaml
for f in ../cluster/core/secrets_decrypted/*.yaml; 
    do echo "encrypting ${f##*/}"; sops -e $f > ../cluster/core/secrets/${f##*/}; 
done
sops --encrypt --in-place ../cluster/core/cert-manager/secret.enc.yaml

kubectl apply --kustomize=../cluster/base/flux-system
kubectl apply --kustomize=../cluster/base/flux-system