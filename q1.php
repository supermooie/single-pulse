<?php
require_once("Config.php");
require_once("Classes/Questions.php");

$smarty = new Smarty();
$smarty->template_dir = SMARTY_TEMPLATE_DIR;
$smarty->compile_dir = SMARTY_COMPILE_DIR;

get_questions($smarty, QUESTIONS_DIR."q1.txt");

$smarty->display("q1.tpl");
?>
