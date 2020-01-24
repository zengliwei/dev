FROM php:7.3-fpm

#
# Install PHP
#
RUN apt-get update \
    && apt-get -y install \
        libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
        libicu-dev \
        libxslt-dev \
        libzip-dev \
    && docker-php-ext-install -j$(nproc) bcmath intl opcache pdo_mysql soap xml xsl zip \
    && docker-php-ext-configure gd --with-freetype-dir --with-jpeg-dir \
    && docker-php-ext-install -j$(nproc) gd \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug
COPY php/php.ini "$PHP_INI_DIR/"

#
# Install MSMTP for sending email
#
RUN apt-get update \
    && apt-get -y install msmtp
COPY linux/msmtprc /etc/

#
# Install Nginx
#
RUN apt-get update \
    && apt-get -y install nginx
COPY nginx/sites-enabled/*.conf /etc/nginx/sites-enabled/
COPY nginx/*.conf /etc/nginx/

#
# Install SSH
#
ARG SSH_PSWD=root
RUN apt-get update \
    && apt-get -y install openssh-server \
    && sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config \
    && sed -i 's/#ClientAliveInterval 0/ClientAliveInterval 30/g' /etc/ssh/sshd_config \
    && sed -i 's/#ClientAliveCountMax 3/ClientAliveCountMax 1200/g' /etc/ssh/sshd_config \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config \
    && sed -i 's/www-data:\/var\/www:\/usr\/sbin\/nologin/www-data:\/var\/www:\/bin\/bash/g' /etc/passwd \
    && echo "root:${SSH_PSWD}" | chpasswd \
    && echo "www-data:${SSH_PSWD}" | chpasswd
COPY linux/.bashrc /root/
COPY linux/.bashrc /var/www/
COPY linux/.profile /var/www/

#
# Rebuild file structure
#
RUN mv /var/www/html /var/www/localhost \
    && rm -rf /var/www/localhost/* \
    && chmod 0775 /var/www/localhost \
    && chown -R www-data:www-data /var/www

#
# Prepare for start
#
COPY docker-bootstrap /usr/local/bin/
WORKDIR /var/www
EXPOSE 22 80

CMD ["docker-bootstrap"]