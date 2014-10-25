FROM petitchevalroux/php-fpm:5.4
MAINTAINER Patrick Poulain <docker@m41l.me>
RUN apt-get update
RUN apt-get -y install git php5-gd
RUN rm -rf /var/www/*
RUN git clone https://github.com/pluxml/PluXml.git /var/www  
RUN apt-get -y purge git
RUN apt-get -y autoremove
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN find /var/www -type d -exec chmod o=rx {} \;
RUN find /var/www -type f -exec chmod o=r {} \;
RUN chown -R www-data:www-data /var/www/data
RUN usermod -u 1000 www-data