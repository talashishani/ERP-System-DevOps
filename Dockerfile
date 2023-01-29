FROM ubuntu:22.04

ARG branchh

RUN apt-get update && apt-get upgrade -y\
    && apt-get install -y git\ 
    && apt-get install -y net-tools\
    && apt-get install -y nodejs\
    && apt install -y python3.10\ 
    && apt-get install -y python3-dev\
    && apt-get install -y python3-setuptools python3-pip\
    && apt-get install -y virtualenv\
    && apt install -y python3.10-venv\
    && apt-get install -y software-properties-common\ 
    && apt-get install -y redis-server\
    && DEBIAN_FRONTEND=noninteractive apt-get install -y xvfb libfontconfig wkhtmltopdf\ 
    && apt-get install -y libmysqlclient-dev\ 
    && apt install -y curl\ 
    && apt-get install -y cron\
    && apt-get install -y mariadb-client\
    && apt-get install -y vim\ 
    && apt-get install -y git-core subversion build-essential gcc-multilib sudo

RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash\
    && apt-get install -y npm\
    && npm install -g yarn\
    && npm cache clean -f\
    && npm install -g n\
    && n stable\
    && n latest

RUN git clone --branch main-1 https://gitlab.com/talashishani/frappe.git\
    && pip3 install frappe-bench\
    && apt-get install -y nginx\
    && apt install -y supervisor\
    && mkdir -p /var/log/supervisor
    
EXPOSE 80

RUN apt-get update\
    && apt-get upgrade -y\
    && service supervisor start

RUN adduser --disabled-password --gecos "" tala \
    && usermod -aG sudo tala  \
    && echo "%sudo  ALL=(ALL)  NOPASSWD: ALL" > /etc/sudoers.d/sudoers 
    
RUN chown tala /home/tala\
    && chown tala /usr/sbin/nginx

USER tala 
WORKDIR /home/tala  
RUN bench init --frappe-branch main-1 --frappe-path https://gitlab.com/talashishani/frappe.git frappe-bench

WORKDIR /home
RUN chown tala /home/tala/frappe-bench

WORKDIR /home/tala/frappe-bench
RUN bench setup supervisor\
    && bench setup nginx 

WORKDIR /etc/supervisor/conf.d
RUN sudo touch frappe.conf 
WORKDIR /home
RUN chown tala /home/tala/frappe-bench/config\
    && sudo ln -S /home/tala/frappe-bench/config/supervisor.conf /etc/supervisor/conf.d/frappe.conf

ENTRYPOINT ["tail", "-f", "/dev/null"]
