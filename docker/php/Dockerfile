# ./docker/php/Dockerfile
FROM bitnami/php-fpm:7.4

#Install SURY repo to install php7.4 extensions
RUN apt-get update && \
apt-get install -y \
zlib1g-dev && \
sudo apt install -y curl wget gnupg2 ca-certificates lsb-release apt-transport-https &&\
wget https://packages.sury.org/php/apt.gpg &&\
sudo apt-key add apt.gpg && \
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php7.list && \
sudo apt update && \
##Install php7.4 extensions
sudo apt install -y php7.4-mysql php7.4-curl php7.4-json php7.4-gd php7.4-mbstring php7.4-intl php7.4-bcmath php7.4-bz2 php7.4-readline php7.4-zip

#Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === 'baf1608c33254d00611ac1705c1d9958c817a1a33bce370c0595974b342601bd80b92a3f46067da89e3b06bff421f182') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --filename=composer \
    && php -r "unlink('composer-setup.php');" \
    && mv composer /usr/local/bin/composer

RUN adduser -home /home/exploit exploit -u 1000

WORKDIR /usr/src/app

RUN PATH=$PATH:/usr/src/apps/vendor/bin:bin