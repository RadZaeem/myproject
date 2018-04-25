<?php
/**
 * @file
 * Installation steps for the profile myproject.
 */

/**
 * Implements hook_form_FORM_ID_alter().
 *
 * Allows the profile to alter the site configuration form.
 */
function myproject_form_install_configure_form_alter(&$form, $form_state) {
  // Pre-populate the site name with the server name.
  $form['site_information']['site_name']['#default_value'] = 'Myproject';
}

/**
 * Implements hook_install_tasks().
 */
function myproject_install_tasks($install_state) {
  // Add our custom CSS file for the installation process
  drupal_add_css(drupal_get_path('profile', 'myproject') . '/myproject.css');

  module_load_include('inc', 'phpmailer', 'phpmailer.admin');
  //module_load_include('inc', 'myproject', 'myproject.admin');

  $tasks = array(
    'myproject_mail_config' => array(
      'display_name' => st('Mail Settings'),
      'type' => 'form',
      'run' => INSTALL_TASK_RUN_IF_NOT_COMPLETED,
      'function' => 'phpmailer_settings_form',
    ),
    /*
    'myproject_config' => array(
      'display_name' => st('Myproject Settings'),
      'type' => 'form',
      'run' => INSTALL_TASK_RUN_IF_NOT_COMPLETED,
      'function' => 'myproject_config',
    ),
    */
  );

  return $tasks;
}
