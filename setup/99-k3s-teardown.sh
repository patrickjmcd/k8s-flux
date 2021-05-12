source env.vars

ssh $SERVER_IP "/usr/local/bin/k3s-uninstall.sh"
ssh $WORKER_1_IP "/usr/local/bin/k3s-agent-uninstall.sh"
ssh $WORKER_2_IP "/usr/local/bin/k3s-agent-uninstall.sh"

