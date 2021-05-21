source env.vars

IFS=',' read -ra SERVER_IPS <<< "$SERVERS"

if [ "${#SERVER_IPS[@]}" -gt 1 ]; then
    k3sup install --ip ${SERVER_IPS[0]} \
      --user $SERVER_USER \
      --cluster \
      --k3s-extra-args '--no-deploy traefik --no-deploy servicelb --write-kubeconfig-mode 644'  \
      --ssh-key ~/.ssh/swarm \
      --k3s-version v1.21.0+k3s1

    for IP in "${SERVER_IPS[@]:1}"
    do
        k3sup join --ip $IP \
          --server \
          --server-ip $SERVER_IP \
          --server-user $SERVER_USER \
          --user $SERVER_USER \
          --ssh-key ~/.ssh/swarm \
          --k3s-version v1.21.0+k3s1
    done
else
    k3sup install --ip ${SERVER_IPS[0]} \
      --user $SERVER_USER \
      --k3s-extra-args '--no-deploy traefik --no-deploy servicelb --write-kubeconfig-mode 644'  \
      --ssh-key ~/.ssh/swarm \
      --k3s-version v1.21.0+k3s1
fi



IFS=',' read -ra WORKER_IPS <<< "$WORKERS"

for IP in "${WORKER_IPS[@]}"
do
    k3sup join --ip $IP \
      --server-ip $SERVER_IP \
      --server-user $SERVER_USER \
      --user $SERVER_USER \
      --ssh-key ~/.ssh/swarm \
      --k3s-version v1.21.0+k3s1
done
