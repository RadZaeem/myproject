<?php
/**
 * @file
 * proj_captcha.features.inc
 */

/**
 * Implements hook_ctools_plugin_api().
 */
function proj_captcha_ctools_plugin_api($module = NULL, $api = NULL) {
  if ($module == "strongarm" && $api == "strongarm") {
    return array("version" => "1");
  }
}
