FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
COPY init.sql /docker-entrypoint-initdb.d/
COPY . /redmine
WORKDIR /redmine
RUN bundle install
RUN chmod +x db_create_migrate.sh