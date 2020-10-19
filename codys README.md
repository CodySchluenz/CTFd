1. start rhel7 ec2 instance in AWS console

ports: 8000, 8000, 9000, 22, 4000?
-----------------------------------------
2. log in as root user:

sudo passwd
pass1337
pass1337
su -
pass1337
-----------------------------------------
3. install docker

yum update -y
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sed -i 's/$releasever/7/' /etc/yum.repos.d/docker-ce.repo
yum-config-manager --enable rhel-7-server-rhui-extras-rpms
													yum --enablerepo=* install container-selinux    # not needed if you use line 18

yum install -y docker-ce docker-ce-cli containerd.io
#yum list docker-ce --showduplicates | sort -r
# yum install docker-ce-19.03.13 docker-ce-cli-19.03.13 containerd.io
systemctl start docker
-----------------------------------------
4. install docker-compose

 curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
 chmod +x /usr/local/bin/docker-compose
-----------------------------------------
5. download CTFd from github

yum install wget -y
wget -O /tmp/CTFd-3.1.2.zip https://github.com/CodySchluenz/CTFd/archive/3.1.2.zip
yum install unzip -y
unzip /tmp/CTFd-3.1.2.zip  -d /opt/secutil
rm -f /tmp/CTFd-3.1.2.zip 
chmod +x /opt/secutil/CTFd-3.1.2
-----------------------------------------
6. create and run CTFd stack

cd /opt/secutil/CTFd-3.1.2
docker-compose up
-----------------------------------------
7. create and run portainer stack

docker volume create portainer_data
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
-----------------------------------------
8. log in to portainer and CTFd with EC2 IPv4 Public IP

portainer:
	URL: 54.173.92.28:9000
	username: admin
	password: password
	Select docker environment
	
CTFd:
	URL: 54.173.92.28:8000
	username: admin
	password: password
-----------------------------------------
9. Optional remove rmi's

docker system prune
docker images -a
docker rmi Image <REPOSITORY> or docker rmi Image <IMAGE ID>

you should have no repositories left (check with docker images -a).
you can now run 'docker-compose up' from the directory of the docker-compose.yml file

cat /etc/yum.repos.d/docker-ce.repo
