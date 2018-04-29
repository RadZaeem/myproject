# DrupalBox-Redis Example

This docker-scripts demonstrates usage of Drupal Redis module with Redis docker-scripts container

This is based on original docker-scripts dbox container (https://github.com/docker-scripts/dbox)

### Differences with original dbox container
 - `settings.sh` has optional `REDIS_HOST` variable to specify Redis server hostname.
   - By default it the value is `redis`
 - `install/redis-config.sh` is injected during `ds config`
   - checks whether `REDIS_HOST` is not empty, and if it is not empty, installs and configures Redis

## Install the DrupalBox-Redis Example

  - Install Docker:
    https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository

  - Install `ds`,`wsproxy` and `mariadb`:
     + https://github.com/docker-scripts/ds#installation
     + https://github.com/docker-scripts/wsproxy#installation
     + https://github.com/docker-scripts/mariadb#installation


  - Clone this repo to `opt/docker-scripts/myproject` like this:
```
    git clone https://github.com/radzaeem/myproject /opt/docker-scripts/myproject
```

  - Create a directory for the container: `ds init myproject/ds @proj-example-org`

  - Optional: Fix the settings if needed
```
    cd /var/ds/proj-example-org/
    vim settings.sh
```

  - Build image, create the container and configure it: 
```
ds build
ds create
ds make
```


## Access the website

  - If the domain is not a real one, add to `/etc/hosts` the line
    `127.0.0.1 proj.example.org` and then try
    https://proj.example.org in browser.

  - If you already have the domain, tell `wsproxy` to manage the domain of this container: `ds wsproxy add`

  - Tell `wsproxy` to get a free letsencrypt.org SSL certificate for this domain (if it is a real one):
    ```
    ds wsproxy ssl-cert --test
    ds wsproxy ssl-cert
    ```

## Testing connection with Redis container

Check whether Redis server's `keys` named `cache_boot` is actually used by Drupal.

```bash
# hostname of Redis server is 'redis'
cd /var/ds/proj-example-org
ds shell
redis-cli -h redis 
keys *cache_boot*
exit
```

Example output
```bash
(proj-example-org)root@proj-example-org:/var/www
==> # redis-cli -h redis
redis:6379> keys *cache_boot*
1) "3830eb70bda1d214ee12d28fbb4d30e1:cache_bootstrap:system_list"
2) "3830eb70bda1d214ee12d28fbb4d30e1:cache_bootstrap:bootstrap_modules"
3) "3830eb70bda1d214ee12d28fbb4d30e1:cache_bootstrap:module_implements"
4) "3830eb70bda1d214ee12d28fbb4d30e1:cache_bootstrap:lookup_cache"
5) "3830eb70bda1d214ee12d28fbb4d30e1:cache_bootstrap:_last_flush"
6) "3830eb70bda1d214ee12d28fbb4d30e1:cache_bootstrap:hook_info"
```
## Other commands

Other commands are same as the original `dbox` container (https://github.com/docker-scripts/dbox)

    ds help

    ds shell
    ds stop
    ds start
    ds snapshot

    ds inject set-adminpass.sh <new-drupal-admin-passwd>
    ds inject set-domain.sh <new.domain>
    ds inject set-emailsmtp.sh <gmail-user> <gmail-passwd>

    ds inject dev/clone.sh test
    ds inject dev/clone-del.sh test
    ds inject dev/clone.sh 01

    ds backup [proj1]
    ds restore <backup-file.tgz> [proj1]
