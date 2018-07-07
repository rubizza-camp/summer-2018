sudo docker build .
sudo docker-compose run web rake db:create
sudo docker-compose run web rake db:migrate
sudo docker-compose up
