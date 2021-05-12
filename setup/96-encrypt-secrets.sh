#! /bin/bash
for f in ../cluster/core/secrets_decrypted/*.yaml; 
    do echo "encrypting ${f##*/}"; sops -e $f > ../cluster/core/secrets/${f##*/};
done