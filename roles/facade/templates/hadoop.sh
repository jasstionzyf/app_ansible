#!/bin/bash
ansible-playbook -i hosts.yml main.yml  -u zhaoyufei -t hp_file_permission --limit gpu0
#ansible-playbook -i hosts.yml main.yml  -u zhaoyufei -t hp_install --limit gpu0
ansible-playbook -i hosts.yml main.yml  -u zhaoyufei -t hp_config --limit gpu0
ansible-playbook -i hosts.yml main.yml  -u zhaoyufei -t cgroup_init --limit gpu0
ansible-playbook -i hosts.yml main.yml  -u zhaoyufei -t hp_ce --limit gpu0

ansible-playbook -i hosts.yml main.yml  -u zhaoyufei -t zk_start --limit gpu0
ansible-playbook -i hosts.yml main.yml  -u zhaoyufei -t hadoop_restart_namenode --limit gpu0
ansible-playbook -i hosts.yml main.yml  -u zhaoyufei -t hadoop_restart_datanode --limit gpu0
ansible-playbook -i hosts.yml main.yml  -u zhaoyufei -t hbase_start --limit gpu0
ansible-playbook -i hosts.yml main.yml  -u zhaoyufei -t hadoop_restart_resourcemanager --limit gpu0
ansible-playbook -i hosts.yml main.yml  -u zhaoyufei -t hadoop_restart_nodemanager --limit gpu0
