# Steps to follow

## In VPC1

- Create ansible copy project for copying mule runtime and fssm API project to EC2 instance in VPC1.
- Install ansible in EC2 in VPC1
 ```
 sudo apt update
 sudo apt install software-properties-common
 sudo add-apt-repository --yes --update ppa:ansible/ansible
 sudo apt install ansible
  ```
  
- Install openjdk(using ansible) in EC2 instance
- Instll maven (using ansible) in EC2 instance
- Create home directory for mule (using Ansible)
- copy mule binary to mule home dir (using Ansible)
- Setup java maven homes
```
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export MAVEN_HOME=/usr/share/maven
```
- Give executable perms on mule bin 
- Package the invenory API app into jar file and place it inside `apps` folder in mule runtime
- Integrate mule runtime with Anypoint Platform(using Ansible)
- start the mule with `mule start` command and see the server running from Anypoint platform UI
 

## In VPC2

- In VPC2 EC2 instance(RDS), install mysql
```
sudo apt update
sudo apt install mysql-server
sudo systemctl start mysql.service
```
- create `mule` user.
```
CREATE USER 'mule'@'172.31.95.28' IDENTIFIED BY 'xxxxx';
```
	
- Provide these grants from RDS in VPC2 to EC2 Instance in VPC1
```
mysql> GRANT ALL PRIVILEGES ON *.* TO 'mule'@'172.31.95.28' WITH GRANT OPTION;
Query OK, 0 rows affected (0.00 sec)
```

- In RDS, update mysql conf (bind ex2 instance private ip address) then restart the mysql 
```
/etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql
 ```

## More details will be presented in power point presentation(`MulePresentation.pptx`)

![Demo](file:///Users/rohiththeerdham/Documents/mule.gif)
