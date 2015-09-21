FROM nginx

# Nginx configuration
ADD assets/pluxml.conf /etc/nginx/conf.d/pluxml.conf
RUN rm /etc/nginx/conf.d/default.conf

# install pluxml and dependencies
RUN apt-get update && \
	apt-get -y install git php5-gd php5-fpm supervisor && \
	git clone https://github.com/pluxml/PluXml.git /var/www && \
	apt-get purge git -y && apt-get autoremove -y && \
	rm -rf /var/www/.git /var/lib/apt/lists/*

# Set php-fpm socket listent
RUN sed -i -e 's/listen.owner = www-data/listen.owner = nginx/g' /etc/php5/fpm/pool.d/www.conf
RUN sed -i -e 's/listen.group = www-data/listen.group = nginx/g' /etc/php5/fpm/pool.d/www.conf

# Supervisor conf
ADD assets/supervisor.conf /etc/supervisor/conf.d/

RUN chown -R www-data:nginx /var/www/

# pluxml volume
VOLUME /var/www/data/

CMD ["/usr/bin/supervisord", "-n"]
