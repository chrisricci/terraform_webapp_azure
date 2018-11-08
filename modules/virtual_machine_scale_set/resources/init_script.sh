#!/bin/bash
export MYSQL_DATABASE_USER="${mysql_db_admin}"
export MYSQL_DATABASE_PASSWORD="${mysql_db_password}"
export MYSQL_DATABASE_DB="${mysql_db_name}"
export MYSQL_DATABASE_HOST="${mysql_db_host}"
git clone https://github.com/cricci82/PythonFlaskMySQLApp---Part-1.git
sudo apt-get update
yes | sudo apt install python-pip
yes | pip install flask-mysql
python PythonFlaskMySQLApp---Part-1/app.py