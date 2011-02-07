<?php
/*
This page displays the results of the module.
Things like: 
- a folded profile
- an animation of the folding
- the calculated period
- the catalog period
- an estimate of the speed of the surface of the pulsar
*/
require_once("Config.php");
require_once("Classes/Identifier.php");
require_once("Classes/DataValidation.php");
require_once("Classes/ReadInfo.php");
define(THIS_PAGE, "result.php");

Identifier::Init(THIS_PAGE);
$id = Identifier::GetId();

$smarty = new Smarty();

//get pulsar selection information
if(array_key_exists("pulsar", $_GET))
	$smarty->assign("pulsar", DataValidation::removeXSS($_GET["pulsar"]));
if(array_key_exists("id", $_GET))
	$smarty->assign("id", $id);
$pulsar_name = "";
if(array_key_exists("pulsar", $_GET)){
	$pulsar_name = basename(DataValidation::removeXSS($_GET["pulsar"]));
	$smarty->assign("pulsar", $pulsar_name);
}
$dat_fname = "";
$pfname = "";
if(array_key_exists("pfname", $_GET)){
	$dat_fname = DataValidation::removeXSS($_GET["pfname"]);
	$pfname = basename($dat_fname);
	$smarty->assign("pfname", $pfname);
	#print basename($dat_fname);
	$dat_fname = str_replace(".bin", ".info", basename($dat_fname));
	$dat_fname = OBSERVATIONS_DIR.$pulsar_name."/".$dat_fname;
}
$pperiod = "";
if(array_key_exists("period", $_POST)){
	$pperiod = DataValidation::removeXSS($_POST["period"]);
	$smarty->assign("period", $pperiod);
}

$ninfo = read_info($dat_fname);

if(array_key_exists("period", $ninfo)){
	$smarty->assign("period_correct", $ninfo["period"]);
}

#round the period from the info file to the number of significant figures given by the student
$period_len = 0;
$period_round = 0.0;
if(array_key_exists("period", $ninfo) && array_key_exists("period", $_POST)){
	$i=0;
	for(;$i < strlen($pperiod);$i+=1){
		if($pperiod[$i] == ".")
			break;
	}
	$i=strlen($pperiod)-$i-1;
	$period_round = (string)(round($ninfo["period"], $i));
}

#build the display string for the students period
#such that correct digits = green, incorrect = red, accounting for rounding
if(array_key_exists("period", $ninfo) && array_key_exists("period", $_POST)){
	$pcol = "<font color=\"#008000\">";
	$i = 0;
	for(;$i < min(strlen($ninfo["period"]), strlen($pperiod));$i+=1){
		if($period_round[$i] != $pperiod[$i])
			break;
		$pcol = $pcol.$pperiod[$i];
	}
	$pcol .= "</font>";
	$pcol .= "<font color=\"#B22222\">";
	for(;$i < strlen($pperiod);$i+=1){
		$pcol = $pcol.$pperiod[$i];
	} $pcol .= "</font>";
	$smarty->assign("period_color", $pcol);
}

$period = (double)($pperiod);

#format the difference between students period and catalog period
#so that it uses standard conventions
$pdiff = abs($period - (double)$ninfo["period"]);
$ext = "";
if($pidff >= 1E24){
	$ext = "Y";
	$pdiff/=1E24;
}else if($pdiff >= 1E21){
	$ext = "Z";
	$pdiff/=1E21;
}else if($pidff >= 1E18){
	$ext = "E";
	$pdiff/=1E18;
}else if($pdiff >= 1E15){
	$ext = "P";
	$pdiff/=1E15;
}else if($pdiff >= 1E12){
	$ext = "T";
	$pdiff/=1E12;
}else if($pdiff >= 1E9){
	$ext = "G";
	$pdiff/=1E9;
}else if($pdiff >= 1E6){
	$ext = "M";
	$pdiff/=1E6;
}else if($pdiff >= 1E3){
	$ext = "k";
	$pdiff/=1E3;
}else if($pidff >= 1){
	$ext = "";
}else if($pdiff >= 0.001){
	$ext = "m";
	$pdiff/=0.001;
}else if($pdiff >= 0.000001){
	$ext = "&#956;"; //html code for mu
	$pdiff/=0.000001;
}else if($pdiff >= 0.000000001){
	$ext = "n";
	$pdiff/=0.000000001;
}else if($pdiff >= 1E-12){
	$ext = "p";
	$pdiff/=1E-12;
}else if($pdiff >= 1E-15){
	$ext = "f";
	$pdiff/=1E-15;
}else if($pdiff >= 1E-18){
	$ext = "a";
	$pdiff/=1E-18;
}else if($pdiff >= 1E-21){
	$ext = "z";
	$pdiff/=1E-21;
}else if($pdiff >= 1E-24){
	$ext = "y";
	$pdiff/=1E-24;
}
$ext = $ext."s";
$ext = round($pdiff)." ".$ext;
$smarty->assign("pdiff", $ext);

$outfile_name = "fpf".$id.".gif";
$outfile = SESSION_DIR.$outfile_name;
$plotfile = SESSION_DIR.$outfile_name.".plot";
$infile = OBSERVATIONS_DIR.basename($pulsar_name)."/".basename($pfname);

//fold the pulsar at the students period
//build a plot of the folded pulsar
//make an animation of the pulsar folding using the students pulse period
exec("cd ".BIN_DIR." && ./foldbin ".escapeshellarg($infile)." ".escapeshellarg($period)." ".escapeshellarg($plotfile));
exec("cd ".BIN_DIR." && python build_plot.py ".escapeshellarg($plotfile)." ".escapeshellarg($outfile)." 0 0 just_plot");
exec("cd ".BIN_DIR." && ./mk_fold_animation.sh ".escapeshellarg($infile)." ".$period." 20 "."ani".$id." 2 ");
$smarty->assign('fold_ani', WEB_SESSION_ADDRESS."ani".$id.".gif");
$smarty->assign('plot_img', WEB_SESSION_ADDRESS.$outfile_name);

$smarty->template_dir = SMARTY_TEMPLATE_DIR;
$smarty->compile_dir = SMARTY_COMPILE_DIR;

$smarty->display("result.tpl");
?>
