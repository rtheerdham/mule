
## In VPC2 EC2 instance(RDS), create these users.
	```
	CREATE USER 'mule'@'172.31.95.28' IDENTIFIED BY 'xxxxxx';
	CREATE USER 'root'@'172.31.95.28' IDENTIFIED BY 'xxxxxx';
	```

## Provide these grants from RDS instance to EC2 Instance
	```
	mysql> GRANT ALL PRIVILEGES ON mysql.inventory_item TO 'root'@'172.31.95.28' WITH GRANT OPTION;
	Query OK, 0 rows affected (0.01 sec)
	
	mysql> GRANT ALL PRIVILEGES ON mysql.inventory_item TO 'mule'@'172.31.95.28' WITH GRANT OPTION;
	Query OK, 0 rows affected (0.00 sec)
	
	#for testing
	mysql> REVOKE ALL PRIVILEGES ON *.* FROM 'mule'@'172.31.95.28';
	```

## In RDS instance, update mysql conf (bind ex2 instance private ip address) then restart the mysql 
  	```
  	/etc/mysql/mysql.conf.d/mysqld.cnf
  	sudo systemctl restart mysql
  	```
