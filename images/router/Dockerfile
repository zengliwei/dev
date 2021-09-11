FROM nginx

COPY nginx/* /etc/nginx/

#
# Install SSH
#
ARG ssh_pswd=root
RUN apt-get update \
    && apt-get -y install openssh-server \
    && sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config \
    && sed -i 's/#ClientAliveInterval 0/ClientAliveInterval 0/g' /etc/ssh/sshd_config \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config \
    && sed -i 's/www-data:\/var\/www:\/usr\/sbin\/nologin/www-data:\/var\/www:\/bin\/bash/g' /etc/passwd \
    && echo "root:${ssh_pswd}" | chpasswd
COPY linux/.bashrc /root/
COPY linux/.bashrc /var/www/
COPY linux/.profile /var/www/

#
# Install Openssl
#
RUN apt-get update \
    && apt-get -y install openssl

COPY ./docker-bootstrap /usr/local/bin/

EXPOSE 22

CMD ["docker-bootstrap"]