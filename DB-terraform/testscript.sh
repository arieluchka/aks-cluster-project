#!/bin/bash
sudo apt-get update
sudo apt-get install -y postgresql postgresql-contrib
sudo systemctl start postgresql.service

sudo -u postgres psql -c "CREATE DATABASE aks-project-db;"
sudo -u postgres psql -c "CREATE USER python WITH PASSWORD 'pythonTEST123_';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE aks-project-db TO python;"

echo "listen_addresses = '*'" | sudo tee -a /etc/postgresql/*/main/postgresql.conf
echo "host   all    all 10.1.0.0/24     md5" | sudo tee -a /etc/postgresql/*/main/pg_hba.conf
sudo service postgresql restart

#go into flask_db 
sudo -u postgres psql -d flask_db
