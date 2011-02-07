<?php
/*
This page provides information about how folding works and how to improve the period using folding.
*/
require_once("Config.php");
require_once('Classes/Identifier.php');
require_once('Classes/DataValidation.php');
define(THIS_PAGE, 'fold_intro.php');

Identifier::Init(THIS_PAGE);
$id = Identifier::GetId();

$smarty = new Smarty();

//make sure we pass pulsar details through even though this page doesn't really need them
if(array_key_exists("pulsar", $_GET))
	$smarty->assign("pulsar", DataValidation::removeXSS($_GET["pulsar"]));
if(array_key_exists("id", $_GET))
	$smarty->assign("id", $id);
if(array_key_exists("pfname", $_GET))
	$smarty->assign("pfname", DataValidation::removeXSS($_GET["pfname"]));
if(array_key_exists("period", $_POST))
	$smarty->assign("period", DataValidation::removeXSS($_POST["period"]));

$smarty->template_dir = SMARTY_TEMPLATE_DIR;
$smarty->compile_dir = SMARTY_COMPILE_DIR;

$smarty->display("fold_intro.tpl");
?>
