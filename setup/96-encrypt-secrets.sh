#! /bin/bash

sops --encrypt --in-place ../cluster/core/cert-manager/secret.enc.yaml
sops --encrypt --in-place ../cluster/base/cluster-secrets.yaml

for f in ../cluster/core/secrets_decrypted/*.yaml; 
    do echo "encrypting ${f##*/}"; sops -e $f > ../cluster/core/secrets/${f##*/};
done