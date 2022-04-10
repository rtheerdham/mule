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
  
- Install openjdk(using ansible) in EC2
- Instll maven (using ansible) in EC2
- Create home directory for mule (using ansible)
- copy mule binary to mule home dir (using ansible)
- Setup java maven homes
```
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export MAVEN_HOME=/usr/share/maven
```
- Give executable perms on mule bin 

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
