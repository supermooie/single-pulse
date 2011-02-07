<?php
/*
This page is the where students determine a first estimate of the period, using an averaging techique.
They should be able to get around 3 decimal places using this page.
*/
require_once("Config.php");
require_once('Classes/Identifier.php');
require_once('Classes/DataValidation.php');
define(THIS_PAGE, 'findperiod.php');

Identifier::Init(THIS_PAGE);
$id = Identifier::GetId();

//get the zoom co-ordinates
$szoom = 0;
$ezoom = 0;
if(array_key_exists("ezoom", $_POST) && array_key_exists("szoom", $_POST)){
	$szoom = (double)($_POST["szoom"]);
	$ezoom = (double)($_POST["ezoom"]);
}

//get the information required for determining the pulse period
//first pulse time, second pulse time, number of periods between pulses
$first_pulse = 0;
$second_pulse = 0;
$num_pulse = 0;
if(array_key_exists("first_pulse", $_POST)){
	$first_pulse = (double)($_POST["first_pulse"]);
}
if(array_key_exists("second_pulse", $_POST)){
	$second_pulse = (double)($_POST["second_pulse"]);
}
$num_pulse_safe = 1;
if(array_key_exists("num_pulse", $_POST)){
	$num_pulse = (int)($_POST["num_pulse"]);
	$num_pulse_safe = $num_pulse;
	if($num_pulse == 0)
		$num_pulse_safe = 1;
}

//details of which pulsar and detection we are using
if(array_key_exists("pulsar", $_GET)){
	$pulsar_name = DataValidation::removeXSS($_GET["pulsar"]);
}
if(array_key_exists("pfname", $_GET)){
	$pfname = DataValidation::removeXSS($_GET["pfname"]);
	$pfname = str_replace("_sm.png", ".bin", basename($pfname));
}

//make path string for new plot image
$outfile_name = "fp".$id.".gif";
$outfile = SESSION_DIR.$outfile_name;

//TODO: check that this is a valid input file
$infile = OBSERVATIONS_DIR.basename($pulsar_name)."/".$pfname;

//run the image generator
exec("cd ".BIN_DIR." && python build_plot.py ".escapeshellarg($infile)." ".escapeshellarg($outfile)." ".escapeshellarg($szoom)." ".escapeshellarg($ezoom));

//send stuff through to the smarty template
$smarty = new Smarty();
$smarty->assign('szoom', $szoom);
$smarty->assign('ezoom', $ezoom);
$smarty->assign('first_pulse', $first_pulse);
$smarty->assign('second_pulse', $second_pulse);
$smarty->assign('num_pulse', $num_pulse);
$smarty->assign('num_pulse_safe', $num_pulse_safe);
$smarty->assign('id', $id);
$smarty->assign('plot_img', WEB_SESSION_ADDRESS.$outfile_name);
$smarty->assign('pulsar', $pulsar_name);
$smarty->assign('pfname', $pfname);
$smarty->template_dir = SMARTY_TEMPLATE_DIR;
$smarty->compile_dir = SMARTY_COMPILE_DIR;

$smarty->display("findperiod.tpl");
?>
