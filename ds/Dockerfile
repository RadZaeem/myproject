FROM ubuntu:16.04
ENV container docker
# Don't start any optional services except for the few we need.
RUN find /etc/systemd/system \
         /lib/systemd/system \
         -path '*.wants/*' \
         -not -name '*journald*' \
         -not -name '*systemd-tmpfiles*' \
         -not -name '*systemd-user-sessions*' \
         -exec rm \{} \;
RUN systemctl set-default multi-user.target
CMD ["/sbin/init"]

### update and upgrade and install some other packages
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install cron rsyslog logrotate ssmtp logwatch

### add apt repository ppa:ondrej/php
RUN apt-get install -y software-properties-common && \
    LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php && \
    apt-get update && apt-get -y upgrade

### install other tools
RUN apt-get -y install vim git wget curl unzip gawk make diffutils

### install lamp
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get -y install apache2 mysql-client php7.1 php7.1-mysql \
        php7.1-gd php7.1-db php7.1-dev php-pear php7.1-curl \
        php7.1-apcu php7.1-xml php7.1-mbstring php7.1-uploadprogress
RUN update-alternatives --set php /usr/bin/php7.1 && \
    a2dismod php7.2 && a2enmod php7.1

### install drush
RUN wget https://github.com/drush-ops/drush/releases/download/8.1.16/drush.phar && \
    chmod +x drush.phar && \
    mv drush.phar /usr/local/bin/drush && \
    drush --yes init

### install nodejs and less
RUN apt-get -y install npm && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    npm install -g less

### install hub: http://hub.github.com/
RUN curl http://hub.github.com/standalone -sLo /bin/hub && \
    chmod +x /bin/hub

### install twitter cli client
### see: http://xmodulo.com/2013/12/access-twitter-command-line-linux.html
RUN apt-get -y install ruby ruby-dev && \
    gem install t && \
    useradd --system --create-home twitter
