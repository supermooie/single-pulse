<?php
require_once("Config.php");
require_once('Classes/Identifier.php');
require_once('Classes/DataValidation.php');
define(THIS_PAGE, 'fold.php');

Identifier::Init(THIS_PAGE);
$id = Identifier::GetId();

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

$period = (double)($_POST["period"]);

$outfile_name = "fpf".$id.".gif";
$outfile = SESSION_DIR.$outfile_name;
$plotfile = SESSION_DIR.$outfile_name.".plot";
$infile = OBSERVATIONS_DIR.basename($pulsar_name)."/".$pfname;

#print "./foldbin $infile $period $plotfile";
exec("cd ".BIN_DIR." && ./foldbin ".escapeshellarg($infile)." ".escapeshellarg($period)." ".escapeshellarg($plotfile));
exec("cd ".BIN_DIR." && ./build_plot.py ".escapeshellarg($plotfile)." ".escapeshellarg($outfile)." 0 0 just_plot");

$smarty->assign('period', $period);
$smarty->assign('plot_img', WEB_SESSION_ADDRESS.$outfile_name);
$smarty->assign("id", $id);
$smarty->assign("pulsar", $pulsar_name);
$smarty->assign("pfname", $pfname);
$smarty->display("fold.tpl");
?>
