<?php
require_once("Config.php");

$smarty = new Smarty();
$smarty->template_dir = SMARTY_TEMPLATE_DIR;
$smarty->compile_dir = SMARTY_COMPILE_DIR;

$question_text = array();
$questions = array();
$answers = array();
$type = array();

//read the questions
$fin = fopen("questions.txt", "r") or exit("Couldn't open file.");
while(!feof($fin)){
	$fline = fgets($fin);
	if(feof($fin))break;
	if($fline[0] == "#"){
		$questions_text[] = substr($fline, 1);
		$questions[] = array();
		$type[] = "multiselect";
		$correct_text[] = "";
		$answers[] = 0;
	}else if($fline[0] == "%"){
		$questions_text[] = substr($fline, 1);
		$questions[] = array();
		$type[] = "numerical";
		$correct_text[] = "";
		$answers[] = 0;
	}else if($type[count($type)-1] == "numerical" && $fline[0] == "*"){
		if($fline[strlen($fline)-1] == "\n")
			$fline = substr($fline, 0, -1);
		$answers[count($answers)-1] = substr($fline, 1);
	}else if($type[count($type)-1] == "numerical"){
		if($fline[strlen($fline)-1] == "\n")
			$fline = substr($fline, 0, -1);
		$questions[count($questions)-1][] = $fline;
	}else if($fline[0] == "@"){
		if($fline[strlen($fline)-1] == "\n")
			$fline = substr($fline, 0, -1);
		$correct_text[count($correct_text)-1] = substr($fline,1);
	}else{
		if($fline[0] == "*"){
			$answers[count($answers)-1] = count(end($questions));
			$fline = substr($fline, 1);
		}
		$questions[count($questions)-1][] = $fline;
	}
}
fclose($fin);

//randomize the answers
for($i=0;$i<count($questions);$i+=1){
	if($type[$i] != "multiselect")
		continue;
	$nums = range(0, count($questions[$i])-1);
	shuffle($nums);
	$answers[$i] = $nums[$answers[$i]];
	$newq = array();
	$newq = range(0, count($questions[$i])-1);
	$j = 0;
	foreach($nums as $num){
		$newq[$num] = $questions[$i][$j];
		$j+=1;
	}
	$questions[$i] = $newq;
}

$smarty->assign("questions_text", $questions_text);
$smarty->assign("questions", $questions);
$smarty->assign("answers", $answers);
$smarty->assign("types", $type);
$smarty->assign("correct_text", $correct_text);

$smarty->display("questions.tpl");
?>
