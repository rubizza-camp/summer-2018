FROM ruby:2.5.1-slim

MAINTAINER Mikhail Prasmitski <imikailoby@gmail.com>

RUN apt-get update -qq && apt-get install -yqq --fix-missing --no-install-recommends\
  build-essential\
  nodejs\
  git\
  imagemagick\
  libmagickwand-dev\
  libpq-dev\
  postgresql-client

RUN git clone -b '3.4.5' https://github.com/redmine/redmine.git
COPY docker/database.yml redmine/config/database.yml
COPY docker/secrets.yml redmine/config/secrets.yml

ENV REDMINE_PATH /redmine
ENV RAILS_ENV=production
WORKDIR $REDMINE_PATH

RUN gem install bundler && bundle install --without development test

VOLUME ["$REDMINE_PATH/web"]

COPY docker/prepare-and-run-server.sh /
RUN chmod +x /prepare-and-run-server.sh

ENTRYPOINT ["/prepare-and-run-server.sh"]
EXPOSE 3000
