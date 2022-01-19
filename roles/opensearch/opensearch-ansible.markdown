# opensearch anible usage
## avaliable operations
```

ops_syscfg
ops_install
ops_config
ops_clean
ops_start
ops_dashboard_start
ops_dashboard_install
ops_plugins
```

## 如何配置服务器有关opensearch的配置信息？
```
每台服务器有关opensearch的配置信息，比如:你有十台服务器，可能每台服务器的磁盘个数不同，以及每台服务器的内存也不同，
针对每台服务器可能都需要配置opensearch目录对应不同的磁盘以及opensearch jvm分配的大小也不一致
centos_test:
      hosts:
        centos_dev1:
          ansible_port: 22
          ansible_host: 10.112.97.204
          ip: 10.112.97.204
          as_hostname: cvb0.dev.yufei.com
          domains:
            - ip: 10.112.97.204
              domain: cvb0.dev.yufei.com

          op_user: zhaoyufei
          op_user_group: hadoop

          ops_dashboards:

            home: /data/apps/ops_dashboards/
            server.port: 5601
            opensearch.hosts: http://cvb0.dev.yufei.com:9200/
            opensearch.username: yufei.zhao
            opensearch.password: 123546
          ops_cfg:

            node.roles:
              - master
              - data
              # only need for follower node
#              - remote_cluster_client
            cluster.name: comm_dev
#            cluster.name: follower_dev
#            discovery.seed_hosts:
#              - gpu0.dev.yufei.com:9302
#              - gpu0.dev.yufei.com:9303
#
#            cluster.initial_master_nodes:
#              - follower_dev_1
#              - follower_dev_2
            discovery.seed_hosts:
              - cvb0.dev.yufei.com:9300
              - cvb0.dev.yufei.com:9301

            cluster.initial_master_nodes:
              - comm_dev_1
              - comm_dev_2




            bootstrap.memory_lock: false




            node.name: com_dev_1
            http.port: 9200
            transport.tcp.port: 9300

            ops_home: /data/apps/ops_com_dev_1/
            ops_cfgDir: /data/apps/ops_cfg_com_dev_1/
            ops_dataDir: /data2/ops_data_com_dev_1/
            ops_logDir: /data2/ops_logs_com_dev_1/

#            node.name: com_dev_2
#            http.port: 9201
#            transport.tcp.port: 9301
#
#            ops_home: /data/apps/ops_com_dev_2/
#            ops_cfgDir: /data/apps/ops_cfg_com_dev_2/
#            ops_dataDir: /data2/ops_data_com_dev_2/
#            ops_logDir: /data2/ops_logs_com_dev_2/



            xms: -Xms1g
            xmx: -Xmx1g



```

## opensearch 安装流程
```
首先配置ansible 环境变量告诉ansible 本地相关软件的地址:
app_version: 1.2.0
app_libary_dir: /mnt/d/data/software/opensearch/{{app_version}}/opensearch-{{app_version}}-linux-x64.tar.gz
app_plugins_dir: /mnt/d/data/software/opensearch/{{app_version}}/plugins/
ops_dashboard_dir: /mnt/d/data/software/opensearch/{{app_version}}/opensearch-dashboards-1.2.0-linux-x64.tar.gz

然后配置服务器系统用户:
roles->comm->vars->main.yml
设置users


然后运行命令:

ansible-playbook -i hosts/guazi_hosts.yml main.yml  -u root -t user_create --limit centos_test --extra-vars "ansible_sudo_pass=test"   --ask-pass -vvv
ansible-playbook -i hosts/guazi_hosts.yml main.yml  -u root -t passwordless_sudo --limit centos_test --extra-vars "ansible_sudo_pass=test"   --ask-pass

ansible-playbook -i hosts/guazi_hosts.yml main.yml  -u root -t ssh_setup --limit centos_test --extra-vars "ansible_sudo_pass=test"   --ask-pass





创建好用户之后，后续就可以直接以你设定的opensearch的用户来进行安装,比如这里是:zhaoyufei
设置hostName:
ansible-playbook -i hosts/guazi_hosts.yml main.yml  -u zhaoyufei -t setHostName --limit centos_test
接下来顺序执行:
ansible-playbook -i hosts/guazi_hosts.yml main.yml  -u zhaoyufei -t ops_syscfg --limit centos_test
ansible-playbook -i hosts/guazi_hosts.yml main.yml  -u zhaoyufei -t ops_install --limit centos_test

ansible-playbook -i hosts/guazi_hosts.yml main.yml  -u zhaoyufei -t ops_config --limit centos_test
ansible-playbook -i hosts/guazi_hosts.yml main.yml -u zhaoyufei -t ops_dashboard_install --limit centos_test
ansible-playbook -i hosts/guazi_hosts.yml main.yml -u zhaoyufei -t ops_dashboard_config --limit centos_test

ansible-playbook -i hosts/guazi_hosts.yml main.yml  -u zhaoyufei -t ops_plugins --limit centos_test



然后启动opensearch以及dashboard:

ansible-playbook -i hosts/guazi_hosts.yml main.yml  -u zhaoyufei -t ops_start --limit centos_test

ansible-playbook -i hosts/guazi_hosts.yml main.yml  -u zhaoyufei -t pkill --limit centos_test  --extra-vars 'pid=opensearch'
ansible-playbook -i hosts/guazi_hosts.yml main.yml  -u zhaoyufei -t ops_dashboard_start --limit centos_test



```
