<?php
/*
This page shows a list of pulsars available for use with this module and allows
sudents to select a pulsar.
*/

require_once('Config.php');
require_once('Classes/Identifier.php');
require_once('Classes/Pulsars.php');

define('THIS_PAGE', 'pulsars.php');
define('NEXT_PAGE', WEB_ADDRESS . 'observations.php');

Identifier::Init(THIS_PAGE);
$id = Identifier::GetId();

$smarty = new Smarty();

// Defined in 'Config.php'
$smarty->template_dir = SMARTY_TEMPLATE_DIR;
$smarty->compile_dir = SMARTY_COMPILE_DIR;

$pulsars_attributes = GetPulsarsAttributes();

foreach ($pulsars_attributes as $p_attr) {
  $smarty->append('pulsars', array(
    'profile' => $p_attr->profile,
    'name' => $p_attr->name,
    'name_url' => urlencode($p_attr->name),
    'n_observations' => $p_attr->n_observations
  ));
}

$smarty->assign('next_page', NEXT_PAGE);
$smarty->assign('id', $id);

$smarty->display('pulsars.tpl');

/**
 * Get attributes for all PULSE@Parkes pulsars.
 * Attributes:
 *    - pulsar name
 *    - pulse profile link
 *
 * Returns an array of stdClass containing attributes for each PULSE@Parkes
 * pulsar.
 */
function GetPulsarsAttributes()
{
  // Iterate through J* directories from OBSERVATIONS_DIR
  //    * pulsar name = directory name
  //    * pulse profile link = first .png file???

  $pulsars_attributes = array();

  // Names of all PULSE@Parkes pulsars.
  $pulsar_names = Pulsars::$names;

  foreach ($pulsar_names as $name) {
    // Directory on disk for the current pulsar.
    $directory = OBSERVATIONS_DIR . $name . '/';
    $profiles = glob($directory . '*sm.png');

    $pulsar_attributes = new stdClass();
    $pulsar_attributes->name = $name;
    $pulsar_attributes->profile = WEB_OBSERVATIONS_ADDRESS . $name . '/' . basename($profiles[0]);
    $pulsar_attributes->n_observations = count($profiles);

    $pulsars_attributes[] = $pulsar_attributes;
  }

  return $pulsars_attributes;
}

?>
