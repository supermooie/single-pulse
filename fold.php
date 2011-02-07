<?php
/*
This allows students to fold their pulsar at an arbritrary period, hopefully meaning
that they can pin down the period of their pulsar.
*/
require_once("Config.php");
require_once('Classes/Identifier.php');
require_once('Classes/DataValidation.php');
define(THIS_PAGE, 'fold.php');

Identifier::Init(THIS_PAGE);
$id = Identifier::GetId();

//determine which pulsar and detection was selected
$pulsar_name = "";
$pfname = "";
if(array_key_exists("pulsar", $_GET)){
	$pulsar_name = DataValidation::removeXSS($_GET["pulsar"]);
}
if(array_key_exists("pfname", $_GET)){
	$pfname = DataValidation::removeXSS(basename($_GET["pfname"]));
}

$smarty = new Smarty();
$smarty->template_dir = SMARTY_TEMPLATE_DIR;
$smarty->compile_dir = SMARTY_COMPILE_DIR;

//get the new period $_POST["period"] and the old one $_POST["init_period"]
$period = (double)($_POST["period"]);
$init_period = 0;
if(array_key_exists("init_period", $_POST)){
	$init_period = (double)($_POST["init_period"]);
}else{
	$init_period = $period;
}

//make path strings
$outfile_name = "fpf".$id.".gif";
$outfile = SESSION_DIR.$outfile_name;
$plotfile = SESSION_DIR.$outfile_name.".plot";
$infile = OBSERVATIONS_DIR.basename($pulsar_name)."/".$pfname;

//fold the pulsar at the students period
//then plot the folded profile
exec("cd ".BIN_DIR." && ./foldbin ".escapeshellarg($infile)." ".escapeshellarg($period)." ".escapeshellarg($plotfile));
exec("cd ".BIN_DIR." && python build_plot.py ".escapeshellarg($plotfile)." ".escapeshellarg($outfile)." 0 0 just_plot");

//determine the largest peak in the folded file
$mflux = 0;
if(!file_exists($plotfile)) exit;
$fin = fopen($plotfile, "r");
while(!feof($fin)){
	$ln = fgets($fin);
	$parts = explode(" ", $ln);
	$mflux = max($mflux, (double)$parts[1]);	
}
fclose($fin);

$smarty->assign('mflux', $mflux);
$smarty->assign('period', $period);
$smarty->assign('init_period', $init_period);
$smarty->assign('plot_img', WEB_SESSION_ADDRESS.$outfile_name);
$smarty->assign("id", $id);
$smarty->assign("pulsar", $pulsar_name);
$smarty->assign("pfname", $pfname);
$smarty->display("fold.tpl");
?>
