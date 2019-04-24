#!/bin/bash
# setup lnxcfg user
# create lnxcfg user for Ansible automation and configuration management

# create lnxcfg user
getentUser=$(/usr/bin/getent passwd lnxcfg)
if [ -z "$getentUser" ]
then
	echo "User lnxcfg does not exist.  Will Add..."
	/usr/sbin/groupadd -g 2002 lnxcfg
	/usr/sbin/useradd -u 2002 -g 2002 -c "Ansible Automation Account" -s /bin/bash -m -d /home/lnxcfg lnxcfg
	echo "lnxcfg:$6$rounds=656000$22YepH3pyOE5L1R0$t7ycMMKs3tAeGoJO4LifA/quugjlmAtDGWlv94oIasyFyW6.JRpSAv0VEkh2FHYMjhFlPY5Zl3SnH5F9DgLjH/" | /sbin/chpasswd
	mkdir -p /home/lnxcfg/.ssh
fi

# setup ssh authorization keys for Ansible access 
echo "setting up ssh authorization keys..."
cat << 'EOF' >> /home/lnxcfg/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCBMrm90Ca8u6GSbnt4rhT+kr9DqkogtjpNO2QzOzOp32549UCaVoak1uehPTjm+yU4C25c4iKP+XyE8IQP6IkLhm4HVUky2MtR89aznjOn6T8CajcjmXx5mruaTg2HpRyyclSMMQFm7dRxBUsOzFl1FaP5hUChgYClB4O12f6towBN9FEErfQQL74WN4L8YZdv3Rag0Si3exyJ3PgLh3Q6tHxdRTDQ91RV0u9NmIThYyExN7nW7q2byTOVUFj/DBSi+g2+D6qQaiokYRDFHQMOY9bNAxIIE4ydYZgDXWlehEN6wjbpEioJE+SDqBYAR16raFAsm+3rJK/g3A1JZAnh
EOF

chown -R lnxcfg:lnxcfg /home/lnxcfg/.ssh
chmod 700 /home/lnxcfg/.ssh

# setup sudo access for Ansible
if [ ! -s /etc/sudoers.d/lnxcfg ]
then
echo "User lnxcfg sudoers does not exist.  Will Add..."
cat << 'EOF' > /etc/sudoers.d/lnxcfg
User_Alias ANSIBLE_AUTOMATION = %lnxcfg
ANSIBLE_AUTOMATION ALL=(ALL)      NOPASSWD: ALL
EOF
chmod 400 /etc/sudoers.d/lnxcfg
fi

# disable login for lnxcfg except through 
# ssh keys
echo "Updating SSH Config..."
sed -i 's/Allowusers.*/Allowusers root lnxcfg ultraserve/g' /etc/ssh/sshd_config
cat << 'EOF' >> /etc/ssh/sshd_config
Match User lnxcfg
        AuthenticationMethods publickey
EOF

# restart sshd
echo "Restarting sshd service................" 
systemctl restart sshd
# end of script
