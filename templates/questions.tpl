{* Introductory web page for Module Two. A unique ID should be created. *}

{include file="header.tpl" title="Module Three: Questions"}

<script type="text/javascript">
var cur_question = 0;

var answer_len = {$answers|count};
var answer = new Array(answer_len);
var type = new Array(answer_len);
var precision = new Array(answer_len);
{foreach $answers as $answer}
answer[{$answer@index}] = {$answer};
{/foreach}
{foreach $types as $type}
type[{$type@index}] = "{$type}";
{/foreach}
{foreach $questions as $question}
{if $types[$question@index] == "numerical"}
precision[{$question@index}] = {$question[0]};
{else}
precision[{$question@index}] = 0;
{/if}
{/foreach}

function checkAnswers(){
	{*/*var correct = 0;
	for(i=0;i<answer_len;i++){
		//alert("here");
		if(type[i] == "multiselect"){
			if(document.getElementById("q"+i).r1[answer[i]].checked){
				correct+=1;
			}
		}else if(type[i] == "numerical"){
			if((parseFloat(document.getElementById("q"+i).t1.value)).toPrecision(precision[i]) == answer[i].toPrecision(precision[i])){
				correct+=1;
			}
		}
	}
	if(correct != answer_len)
		document.getElementById("ansBox").innerHTML = "Score: "+correct+" / "+answer_len;
	else
		document.getElementById("ansBox").innerHTML = "Score: <font color=\"#008800\">"+correct+" / "+answer_len + " Congratulations! </font>";
	return false;*/*}

	var correct = false;
	if(type[cur_question] == "multiselect"){
		if(document.getElementById("q"+cur_question).r1[answer[cur_question]].checked){
			correct=true;
		}
	}else if(type[cur_question] == "numerical"){
		if((parseFloat(document.getElementById("q"+cur_question).t1.value)).toPrecision(precision[cur_question]) == answer[cur_question].toPrecision(precision[cur_question])){
			correct=true;
		}
	}

	if(correct){
		document.getElementById("fd"+cur_question).style.display = "block";
		document.getElementById("cans1").style.display = "none";
	}else{
		document.getElementById("cross_img").style.display = "block";
	}
	return false;
}

function nextQuestion(){
	document.getElementById("d"+cur_question).style.display = "none";
	document.getElementById("fd"+cur_question).style.display = "none";
	cur_question+=1;
	if(cur_question < answer_len){
		document.getElementById("d"+cur_question).style.display = "block";
		document.getElementById("heading1").innerHTML="Question " + (cur_question + 1) + ":";
		document.getElementById("cans1").style.display = "block";
		document.getElementById("cross_img").style.display = "none";
	}else{
		document.getElementById("finish_screen").style.display="block";
		document.getElementById("heading1").innerHTML="Finished!";
	}
}
</script>

<div id="box">
<h3 id="heading1" >Question 1:</h3>

<div id = "finish_screen" style="display: none">
Congratulations you are now a pulsar expert.<br><br>

Click here to go onwards:
<br><br>
<form>
<input type="submit" value="Onwards">
</form>
</div>

{foreach $questions as $question}
{strip}
{if $question@index eq 0}
<div id="d{$question@index}" style="display: block">
{else}
<div id="d{$question@index}" style="display: none">
{/if}
{$questions_text[$question@index]}
{if $types[$question@index] eq "multiselect"}
<form id="q{$question@index}">
	{foreach $question as $option}
		<input type="radio" name="r1" value="{$option}">{$option}<br>
	{/foreach}
</form>
{elseif $types[$question@index] eq "numerical"}
 <br>
<form id="q{$question@index}" onSubmit="false;">
	<input type="text" name="t1">(to {$question[0]} significant figure{if $question[0] > 1}s{/if})
</form>
{/if}
<br>
<div id="fd{$question@index}" style="display: none">
{$correct_text[$question@index]}
<form>
	<input type="button" onClick="nextQuestion()" value="Next Question."><img src="../images/tick.png">
</form>
</div>
</div>
{/strip}
{/foreach}

{*<div id="ansBox">Score: - / {$answers|count}
</div>
<div id="atmBox">Attempts: 0
</div>*}

<div id="cans1" style="display: block">
<form>
<table>
<tr><td><input type="button" value="Check Answer" onClick="checkAnswers();"></td><td><div id="cross_img" style="display: none"><img src = "../images/cross.png"></div></td></tr>
</table>
</form>
</div>

{include file="footer.tpl"}
