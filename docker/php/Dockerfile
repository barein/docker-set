FROM bitnami/php-fpm:7.4

#Install SURY repo to install php7.4 extensions
RUN apt-get update \
    && apt-get install -y \
    zlib1g-dev \
    && apt install -y nano \
    && apt install -y curl wget gnupg2 ca-certificates lsb-release apt-transport-https \
    && wget https://packages.sury.org/php/apt.gpg \
    && apt-key add apt.gpg \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php7.list \
    && apt update \
##Install php7.4 extensions
    && apt install -y php7.4-mysql php7.4-pgsql php7.4-curl php7.4-json php7.4-gd php7.4-mbstring php7.4-intl php7.4-bcmath php7.4-bz2 php7.4-readline php7.4-zip \
## activate pdo_pgsql extension
#    && sed -rie 's/^;extension=pdo_pgsql$/extension=pdo_pgsql/' /opt/bitnami/php/lib/php.ini \
##Disable opcache
    && sed -rie 's/^opcache.enable = 1$/opcache.enable = 0/' /opt/bitnami/php/lib/php.ini \
##Install php redis extension
    && apt-get -y install autoconf \
    && apt-get -y install gcc make autoconf libc-dev pkg-config \
    && printf "\n" | pecl install redis \
    && sed -i '$ a extension=redis.so' /opt/bitnami/php/lib/php.ini


#Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --filename=composer \
    && php -r "unlink('composer-setup.php');" \
    && mv composer /usr/local/bin/composer

RUN apt-get install -y supervisor

#Create user
ARG USER_ID
ARG GROUP_ID
ARG USERNAME

RUN addgroup --gid $GROUP_ID $USERNAME \
    && adduser \
      --system \
      --uid $USER_ID\
      --gid $GROUP_ID \
      --disabled-password \
      --disabled-login \
      $USERNAME \
    # enable non-root user usage
    && chmod -R g+w /opt/bitnami/php/var /opt/bitnami/php/tmp  /opt/bitnami/php/logs \
    && chgrp -R $USERNAME \
      /opt/bitnami/php/var \
      /opt/bitnami/php/tmp \
      /opt/bitnami/php/logs

USER $USERNAME

WORKDIR /app

RUN PATH=$PATH:/apps/vendor/bin:bin