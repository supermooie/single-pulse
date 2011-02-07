<?php
/*
This page allows students to scroll through all the detections for the pulsar they have selected.
*/

require_once('Config.php');
require_once('Classes/Identifier.php');
require_once('Classes/Pulsars.php');
require_once('Classes/DataFile.php');
require_once('Classes/DataValidation.php');

define('THIS_PAGE', 'observations.php');

Identifier::Init(THIS_PAGE);
$id = Identifier::GetId();

$smarty = new Smarty();

// Defined in 'Config.php'
$smarty->template_dir = SMARTY_TEMPLATE_DIR;
$smarty->compile_dir = SMARTY_COMPILE_DIR;

$pulsar_name = DataValidation::removeXSS($_REQUEST['pulsar']);
$observations_attributes = GetObservationsAttributes($pulsar_name);

foreach ($observations_attributes as $o_attr) {
  $smarty->append('observations', array(
    'profile' => $o_attr->profile,
    'filename' => $o_attr->filename,
    'MJD' => $o_attr->MJD,
    'period' => $o_attr->period,
    'period_error' => $o_attr->period_error
  ));
}

// TODO: check for valid pulsar
$smarty->assign('pulsar_name_url', urlencode($pulsar_name));
$smarty->assign('pulsar_name', $pulsar_name);
$smarty->assign('id', Identifier::GetId());
$smarty->display('observation.tpl');

/**
 * Get attributes for all observations of a single pulsar.
 * Attributes:
 *     - pulse profile link
 *
 * Returns an array of stdClass containing attributes for each observation
 * of a PULSE@Parkes pulsar.
 */
function GetObservationsAttributes($pulsar_name)
{
  $observations_attributes = array();

  $directory = OBSERVATIONS_DIR . $pulsar_name . '/';
  $profiles = glob($directory . '*sm.png');

  foreach ($profiles as $p) {
    $data_filename = str_replace('_sm.png', '.dat', basename($p));
    $data_file_values =
      DataFile::GetValues(OBSERVATIONS_DIR . $pulsar_name . '/' . $data_filename);

    $observation_attributes = new stdClass();
    $observation_attributes->MJD = $data_file_values->MJD;
    $observation_attributes->period = $data_file_values->period;
    $observation_attributes->period_error = $data_file_values->period_error;

    $observation_attributes->filename = basename($p);
    $observation_attributes->profile =
      WEB_OBSERVATIONS_ADDRESS . $pulsar_name . '/' . basename($p);

    $observations_attributes[] = $observation_attributes;
  }

  return $observations_attributes;
}

?>
