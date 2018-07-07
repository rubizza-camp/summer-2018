printf "\n\n=== Set default database data ===\n"
bundle exec rake redmine:load_default_data

printf "\n\n=== Migrate database ===\n"
bundle exec rake db:migrate

printf "\n\n=== Let's run ===\n"
bundle exec rails server webrick -e production
