source env.vars

k3sup install --ip $SERVER_IP \
--user $SERVER_USER \
--k3s-extra-args '--no-deploy traefik --write-kubeconfig-mode 644'  \
--ssh-key ~/.ssh/swarm \
--k3s-version v1.21.0+k3s1
# --merge --context pi3 --local-path /Users/patrickjmcd/.kube/config  \


k3sup join --ip $WORKER_1_IP \
--server-ip $SERVER_IP \
--server-user $SERVER_USER \
--user $SERVER_USER \
--ssh-key ~/.ssh/swarm \
--k3s-version v1.21.0+k3s1


k3sup join --ip $WORKER_2_IP \
--server-ip $SERVER_IP \
--server-user $SERVER_USER \
--user $SERVER_USER \
--ssh-key ~/.ssh/swarm \
--k3s-version v1.21.0+k3s1

