FROM tianon/apache2

RUN apt-get update && apt-get install -yq libapache2-mod-passenger

RUN apt-get update && apt-get install -yq bundler

RUN a2dissite '*' || :
RUN { \
		echo '<VirtualHost *:80>'; \
		echo '  DocumentRoot /apps/rails/public'; \
		echo '  <Directory /apps/rails/public>'; \
		echo '    AllowOverride all'; \
		echo '    Options -MultiViews'; \
		echo '    Require all granted'; \
		echo '  </Directory>'; \
		echo '</VirtualHost>'; \
	} > /etc/apache2/sites-available/rails.conf \
	&& a2ensite rails

# set a few bundle config variables so that a local .bundle in our development directory doesn't screw up our image
ENV BUNDLE_APP_CONFIG /apps/bundle
ENV BUNDLE_PATH /apps/gems

# TODO find a clean way to do this here in such a way that gems like rmagick can install cleanly without first installing libmagickcore-dev
#ONBUILD ADD Gemfile /apps/rails/Gemfile
#ONBUILD ADD Gemfile.lock /apps/rails/Gemfile.lock
#ONBUILD RUN cd /apps/rails && bundle install --deployment
#ONBUILD ADD . /apps/rails
#ONBUILD RUN chown -R www-data:www-data /apps/rails
