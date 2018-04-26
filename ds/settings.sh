APP=myproject/ds

### Docker settings.
IMAGE=myproject
CONTAINER=proj-example-org
DOMAIN="proj.example.org"

### Uncomment if this installation is for development.
DEV=true

### Other domains.
DOMAINS="dev.proj.example.org tst.proj.example.org"

### Gmail account for notifications.
### Make sure to enable less-secure-apps:
### https://support.google.com/accounts/answer/6010255?hl=en
GMAIL_ADDRESS=proj.example.org@gmail.com
GMAIL_PASSWD=

### Admin settings.
ADMIN_PASS=123456

### DB settings
DBHOST=mariadb
DBPORT=3306
DBNAME=proj
DBUSER=proj
DBPASS=proj

# If you want to use Redis, put its hostname or IP address here
# Else you can comment out this variable or set as empty.
# Default value is 'redis'.
REDIS_HOST=redis