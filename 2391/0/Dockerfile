FROM ruby:2.5.1-slim

MAINTAINER Dmitriy Baranov <amareelez@gmail.com>

RUN apt-get update && apt-get install -qq -y build-essential nodejs libpq-dev postgresql-client libmagickwand-dev imagemagick git --fix-missing --no-install-recommends

RUN git clone https://github.com/redmine/redmine.git
COPY config/secrets.yml redmine/config/secrets.yml
COPY config/database.yml redmine/config/database.yml
COPY config/application.patch redmine/application.patch

ENV INSTALL_PATH /redmine
ENV RAILS_ENV=production

WORKDIR $INSTALL_PATH

RUN git apply application.patch

RUN bundle install --without development test

VOLUME ["$INSTALL_PATH/public"]

COPY config/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 3000
