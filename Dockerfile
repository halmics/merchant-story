FROM nginx:1.12
MAINTAINER tsukune

RUN apt-get update && apt-get install -y \
      curl \
      fcgiwrap \
      rsync \
      spawn-fcgi \
      unzip \
      vim \
      wget \
      --no-install-recommends

RUN sed -i 's/www-data/nginx/g' /etc/init.d/fcgiwrap
RUN chown nginx:nginx /etc/init.d/fcgiwrap
ADD ./docker/vhost.conf /etc/nginx/conf.d/default.conf

WORKDIR /var/www/
RUN mkdir ./merchant-story
ADD ./merge.sh .
RUN bash ./merge.sh

CMD sed -i -e "/^\$MASTER_PASSWORD/s/'\w*'/'password'/i" \
      ./merchant-story/watlas/_config.cgi \
    && sed -i -e "/^\$ADMIN_EMAIL/s/'\w*'/'info@localhost'/i" \
      ./merchant-story/watlas/_config.cgi \
    && /etc/init.d/fcgiwrap start && nginx -g 'daemon off;'
