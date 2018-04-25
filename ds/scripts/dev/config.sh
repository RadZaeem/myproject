#!/bin/bash -x

alias=${1:-@local_proj}
tag=$2

drush --yes $alias php-script $CODE_DIR/ds/scripts/dev/config.php $tag
