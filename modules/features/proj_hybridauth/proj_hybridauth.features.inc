<?php
/**
 * @file
 * proj_hybridauth.features.inc
 */

/**
 * Implements hook_ctools_plugin_api().
 */
function proj_hybridauth_ctools_plugin_api() {
  list($module, $api) = func_get_args();
  if ($module == "strongarm" && $api == "strongarm") {
    return array("version" => "1");
  }
}
