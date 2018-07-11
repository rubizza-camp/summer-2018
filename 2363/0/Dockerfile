FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
COPY . /redmine
WORKDIR /redmine
COPY Gemfile /redmine/Gemfile
COPY Gemfile.lock /redmine/Gemfile.lock
RUN bundle install
