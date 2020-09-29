1. start rhel7 ec2 instance in AWS console

ports: 8000, 8500, 9000, 22, 4000?
-----------------------------------------
2. log in as root user:

sudo passwd
pass1337
pass1337
su -
pass1337
-----------------------------------------
3. install docker

sudo yum update -y
#sudo yum install yum-utils -y
sudo yum-config-manager \
	--add-repo \
	https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io -y
#yum list docker-ce --showduplicates | sort -r
#sudo yum install docker-ce-19.03.13 docker-ce-cli-19.03.13 containerd.io
sudo systemctl start docker
-----------------------------------------
4. install docker-compose

sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
-----------------------------------------
5. download CTFd from github

sudo yum install wget -y
wget -O /tmp/CTFd-v3.1.2.zip https://github.com/CodySchluenz/CTFd/archive/3.1.2.zip
sudo yum install unzip -y
unzip /tmp/CTFd-v3.1.2.zip -d /opt/secutil
rm -f /tmp/CTFd-v3.1.2.zip
chmod +x /opt/secutil/CTFd-v3.1.2
-----------------------------------------
6. create and run portainer stack

docker volume create portainer_data
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
-----------------------------------------
7. create and run CTFd stack

cd /opt/secutil/CTFd-v3.1.2
docker-compose up
-----------------------------------------
8. log in to portainer and CTFd with EC2 IPv4 Public IP

portainer:
	URL: 54.173.92.28:9000
	username: admin
	password: password
	Select docker environment
	
CTFd:
	URL: 54.173.92.28:8500
	username: admin
	password: password
-----------------------------------------