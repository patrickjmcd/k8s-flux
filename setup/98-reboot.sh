source env.vars

ssh $SERVER_IP "sudo reboot"
ssh $WORKER_1_IP "sudo reboot"
ssh $WORKER_2_IP "sudo reboot"