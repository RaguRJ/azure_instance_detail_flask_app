[program:pythonapp]
directory=/opt/app
command=/opt/app/env/bin/honcho start -f /opt/app/procfile hello
autostart=true
autorestart=true
user=pythonapp
environment=VIRTUAL_ENV="/opt/app/env",PATH="/opt/app/env/bin",HOME="/home/pythonapp",USER="pythonapp"
stdout_logfile=syslog
stderr_logfile=syslog
