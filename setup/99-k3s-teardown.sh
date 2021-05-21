source env.vars

IFS=',' read -ra SERVER_IPS <<< "$SERVERS"
for IP in "${SERVER_IPS[@]}"
do
    ssh $IP "/usr/local/bin/k3s-uninstall.sh"
done

IFS=',' read -ra WORKER_IPS <<< "$WORKERS"
for IP in "${WORKER_IPS[@]}"
do
    ssh $IP "/usr/local/bin/k3s-agent-uninstall.sh"
done
