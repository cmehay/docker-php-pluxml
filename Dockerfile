FROM nginx

# Nginx configuration
ADD assets/pluxml.conf /etc/nginx/conf.d/pluxml.conf
RUN rm /etc/nginx/conf.d/default.conf

# install pluxml and dependencies
RUN apt-get update && \
	apt-get -y install git php5-gd php5-fpm && \
	git clone https://github.com/pluxml/PluXml.git /var/www && \
	apt-get purge git -y && apt-get autoremove -y && \
	rm -rf /var/www/.git /var/lib/apt/lists/*

# pluxml volume
VOLUME /var/www/data/
ADD assets/data/ /var/www/data/

RUN chown -R www-data:www-data /var/www/
