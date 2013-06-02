if [ ! -f /config/database.yml ]
then
  cp config/database.yml.example config/database.yml 
fi

sudo -u postgres createuser coach-app -s

rake db:drop

rake db:create
rake db:migrate
rake db:seed

rake