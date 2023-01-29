# ERP-System-DevOps

## Dependincies
`sudo apt-get install git
sudo apt install python3.10
sudo apt-get install python3-dev
sudo apt-get install python3-dev
sudo apt-get install python3-setuptools python3-pip
sudo apt-get install virtualenv
sudo apt install python3.10-venv
sudo apt-get install software-properties-common
sudo apt-get install redis-server
sudo apt-get install xvfb libfontconfig wkhtmltopdf
sudo apt-get install libmysqlclient-dev`

## Database 
sudo apt install mariadb-server
sudo mysql_secure_installation
        Switch to unix_socket authentication [Y/n]: Y
        Change the root password? [Y/n]: Y
        Remove anonymous users? [Y/n] Y
        Disallow root login remotely? [Y/n]: N
        Remove test database and access to it? [Y/n]: Y
        Reload privilege tables now? [Y/n]: Y

sudo nano /etc/mysql/mariadb.conf.d/50-server.cnf
       
       `[server]
        user = mysql
        pid-file = /run/mysqld/mysqld.pid
        socket = /run/mysqld/mysqld.sock
        basedir = /usr
        datadir = /var/lib/mysql
        tmpdir = /tmp
        lc-messages-dir = /usr/share/mysql
        bind-address = 127.0.0.1
        query_cache_size = 16M
        log_error = /var/log/mysql/error.log

        [mysqld]
        innodb-file-format=barracuda
        innodb-file-per-table=1
        innodb-large-prefix=1
        character-set-client-handshake = FALSE
        character-set-server = utf8mb4
        collation-server = utf8mb4_unicode_ci      
 
        [mysql]
        default-character-set = utf8mb4`

sudo systemctl restart mariadb.service

## Nginx 
`sudo apt install curl 
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.profile
nvm install 16.15.0
sudo apt-get install npm
sudo npm install -g yarn`

## Frappe-Bench 
`sudo pip3 install frappe-bench
bench init --frappe-branch version-14 frappe-bench
cd frappe-bench/
bench new-site site1.local
bench get-app payments
bench get-app --branch version-14 erpnext
bench --site site1.local install-app erpnext
bench --site site1.local enable-scheduler
bench --site site1.local set-maintenance-mode off
sudo bench setup production [frappe-user]
bench setup nginx
bench config dns_multitenant on
sudo ln -s `pwd`/config/nginx.conf /etc/nginx/conf.d/frappe-bench.conf
sudo service nginx reload`

## Supervisor
`sudo apt-get install supervisor
bench setup supervisor
sudo ln -s `pwd`/config/supervisor.conf /etc/supervisor/conf.d/frappe-bench.conf

sudo systemctl restart supervisor.service mariadb.service redis-server.service
sudo supervisorctl restart all`

## Result 

![1](https://user-images.githubusercontent.com/123273646/215344259-570d03b8-7bde-4148-aefa-a9bc8e0bc538.png)

![2](https://user-images.githubusercontent.com/123273646/215344262-9e4ca783-d116-44d9-beea-965dfb7454af.png)

![3](https://user-images.githubusercontent.com/123273646/215344260-d3eb09b7-14dd-46c7-9fff-fe1a61e7b84a.png)

![4](https://user-images.githubusercontent.com/123273646/215344268-4e0d5120-2569-4adb-acde-29bb890bc23b.png)

![5](https://user-images.githubusercontent.com/123273646/215344278-926687b0-cc90-4844-a5d4-094f0d8ea38a.png)


