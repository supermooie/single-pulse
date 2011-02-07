<?php
/*This page displays the introductory pulsar questions.
*/
require_once("Config.php");
require_once("Classes/Questions.php");

$smarty = new Smarty();
$smarty->template_dir = SMARTY_TEMPLATE_DIR;
$smarty->compile_dir = SMARTY_COMPILE_DIR;

//get all the pulsar questions and get them assigned to smarty variables
get_questions($smarty, QUESTIONS_DIR."q1.txt");

$smarty->display("q1.tpl");
?>
