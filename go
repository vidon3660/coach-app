bundle

if [ ! -f /config/database.yml ]
then
  cp config/database.yml.example config/database.yml 
fi

if [ ! -f /config/sphinx.yml ]
then
  cp config/sphinx.yml.example config/sphinx.yml
fi

sudo -u postgres createuser coach-app -s

rake db:drop

rake db:create
rake db:migrate
rake db:seed

rake ts:index
rake ts:start

rake