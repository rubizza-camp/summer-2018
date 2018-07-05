FROM ruby:2.5.1-slim

MAINTAINER Dmitriy Baranov <amareelez@gmail.com>

RUN apt-get update && apt-get install -qq -y build-essential nodejs libpq-dev postgresql-client libmagickwand-dev imagemagick --fix-missing --no-install-recommends

ENV INSTALL_PATH /redmine
RUN mkdir -p $INSTALL_PATH
ENV RAILS_ENV=production

WORKDIR $INSTALL_PATH

COPY redmine/Gemfile Gemfile
RUN bundle install --without development test

COPY redmine/ .

VOLUME ["$INSTALL_PATH/public"]

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 3000