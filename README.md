# Document

ansible based on functions to admin big data and ai stack

support frameworks:
- [x] hadoop
- [x] kafka
- [x] zookeeper
- [x] elasticsearch
- [x] docker
- [x] conda
- [x] mongo  
- [x] redis (https://github.com/geerlingguy/ansible-role-redis)



software download link: https://pan.baidu.com/s/1K1BuG7ZwM8UPLfuPOzZBaw 提取码: mcm5

使用流程：
使用本项目前需要满足的前提条件：

- 系统为ubuntu-20.04 (目前暂时不支持其他linux版本的系统)
- 每台服务器初始化的时候都要有一个root账号允许通过密码登录(以便通过ansible 创建用户，无密码登录，密钥登陆等配置)

在安装app之前需要对系统进行一些相关的全局配置：
- 指定每个host用于安装app的相关目录，主要三个：app_rootDir，app_dataRootDir，app_logRootDir，app_confRootDir



以安装和启动kafka cluster为例：
假设已经创建了userName: zhaoyufei, group: hadoop,sudo

~~~~
首先从上面提供的百度网盘链接下载software.zip，然后解压到本地目录：your_dir
然后编辑main.yml,设置app_libary_root_dir: your_dir
hosts.yml中指定你需要管理的hosts，比如：vb0
指定此服务器安装的kafka_brokerId
然后运行一下命令安装kafka:
ansible-playbook -i hosts.yml main.yml  -u zhaoyufei -t kafka_install  --limit vb0
安装完成之后启动kafka:
ansible-playbook -i hosts.yml main.yml  -u zhaoyufei -t kafka_start  --limit vb0
用于kill 某台host某个process的命令：
需要设置process_identity唯一的标识你要kill的process name
ansible-playbook -i hosts.yml main.yml  -u zhaoyufei -t pkill --limit hadoop_slave --extra-vars 'pid=process_identity'



本人具体工作中的实际用例:
比如我的一个项目需要用到kafka cluster, elasticsearch cluster ,redis,zookeeper,mongo以及redis
每次我需要启动这些系统用于测试：
ansible-playbook -i hosts.yml main.yml  -u zhaoyufei -t mongo_start  --limit vb0
ansible-playbook -i hosts.yml main.yml  -u zhaoyufei -t zk_start  --limit vb0
ansible-playbook -i hosts.yml main.yml  -u zhaoyufei -t kafka_start  --limit vb0,vb1,vb2
ansible-playbook -i hosts.yml main.yml  -u zhaoyufei -t redis_start  --limit vb0
ansible-playbook -i hosts.yml main.yml  -u zhaoyufei -t es_start  --limit vb0,vb1,vb2
~~~~




       



