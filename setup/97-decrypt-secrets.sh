#! /bin/bash
mkdir -p ../cluster/core/secrets_decrypted; 
for f in ../cluster/core/secrets/*.yaml; 
    do echo "decrypting ${f##*/}"; sops -d $f > ../cluster/core/secrets_decrypted/${f##*/}; 
done