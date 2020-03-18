#!/bin/bash
# Update and install necessary packages
apt-get update -y
apt-get install python3-pip -y
apt-get install python-pip -y
apt-get install git -y
pip install --upgrade pip virtualenv
apt-get install supervisor -y

# Account to own server process
useradd -m -d /home/pythonapp pythonapp

# Fetch source code
export HOME=/root
git clone https://github.com/RaguRJ/azure_instance_detail_flask_app.git /opt/app

# Supervisor configuration
cp /opt/app/supervisord.conf /etc/supervisord.conf

# Python environment setup
virtualenv -p python3 /opt/app/env
source /opt/app/env/bin/activate
/opt/app/env/bin/pip install -r /opt/app/requirements.txt

# Set ownership to newly created account
chown -R pythonapp:pythonapp /opt/app

# Starting and updating the supervisor process
supervisord -c /etc/supervisord.conf
supervisorctl reread
supervisorctl update

# Commands to configure automatic start of pythonapp after system reboot
cp /opt/app/supervisord /etc/init.d/supervisord
chmod +x /etc/init.d/supervisord
chkconfig --add supervisord
chkconfig supervisord on
service supervisord start