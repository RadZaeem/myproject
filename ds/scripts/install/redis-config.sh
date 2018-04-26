source /host/settings.sh

if [ -z "$REDIS_HOST" ];
then
	drush="drush --root=$DRUPAL_DIR --yes"
	$drush @local_proj dl redis
	echo "
// Redis settings
$conf['redis_client_interface'] = 'PhpRedis';
$conf['redis_client_host'] = '$REDIS_HOST';
$conf['lock_inc'] = 'sites/all/modules/redis/redis.lock.inc';
$conf['path_inc'] = 'sites/all/modules/redis/redis.path.inc';
$conf['cache_backends'][] = 'sites/all/modules/redis/redis.autoload.inc';
$conf['cache_default_class'] = 'Redis_Cache';
" >> /host/var-www/proj/sites/default/settings.php 
fi