<?php
/*
This page contains introductory text about the module. It doesn't create and ID.
*/
require_once("Config.php");

$smarty = new Smarty();
$smarty->template_dir = SMARTY_TEMPLATE_DIR;
$smarty->compile_dir = SMARTY_COMPILE_DIR;

$smarty->display("index.tpl");
?>
