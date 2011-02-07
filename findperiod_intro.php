<?php
/*
A page that gives an introduction to finding an approximation of the pulse period.
*/
require_once("Config.php");
require_once('Classes/Identifier.php');
require_once("Classes/DataValidation.php");
define(THIS_PAGE, "findperiod_intro.php");

Identifier::Init(THIS_PAGE);
$id = Identifier::GetId();

$smarty = new Smarty();

//make sure we pass on data about the current pulsar even though it is
//not really needed for this page
if(array_key_exists("pulsar", $_GET))
	$smarty->assign("pulsar", DataValidation::removeXSS($_GET["pulsar"]));
if(array_key_exists("id", $_GET))
	$smarty->assign("id", $id);
if(array_key_exists("pfname", $_GET))
	$smarty->assign("pfname", DataValidation::removeXSS($_GET["pfname"]));

$smarty->template_dir = SMARTY_TEMPLATE_DIR;
$smarty->compile_dir = SMARTY_COMPILE_DIR;

$smarty->display("findperiod_intro.tpl");
?>
