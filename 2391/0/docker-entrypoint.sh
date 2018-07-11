#!/bin/bash

bundle exec rake db:migrate

bundle exec rake redmine:load_default_data

bundle exec rails server webrick -e production