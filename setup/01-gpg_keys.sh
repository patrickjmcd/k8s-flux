export GPG_TTY=$(tty)

source env.vars

gpg --batch --full-generate-key <<EOF
Key-Type: 1
Key-Length: 4096
Subkey-Type: 1
Subkey-Length: 4096
Expire-Date: 0
Name-Real: ${PERSONAL_KEY_NAME}
EOF

gpg --batch --full-generate-key <<EOF
%no-protection
Key-Type: 1
Key-Length: 4096
Subkey-Type: 1
Subkey-Length: 4096
Expire-Date: 0
Name-Real: ${FLUX_KEY_NAME}
EOF

export PERSONAL_KEY_FP=$(gpg --list-secret-keys "${PERSONAL_KEY_NAME}" | grep -Eo "\S{36,}")
export FLUX_KEY_FP=$(gpg --list-secret-keys "${FLUX_KEY_NAME}" | grep -Eo "\S{36,}")

envsubst < ../tmpl/.sops.yaml > ../.sops.yaml
# envsubst < ./tmpl/.sops.yaml > ./.sops.yaml