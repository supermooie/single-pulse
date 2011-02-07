<script type="text/javascript">
var cur_question = 0;

var correct_ft = 0; {* number correct first time *} 
var first_time = true; {* is this the first time the question is answered *}

var answer_len = {$answers|count};
var answer = new Array(answer_len); {*either index to correct option or numerical result*}
var type = new Array(answer_len); {*"multiselect" or "numerical"*}
var precision = new Array(answer_len); {*precision for numerical questions*}

{*setup the javascript variables describing the question types and answers*}

{*write answers to the page*}
{foreach $answers as $answer}
answer[{$answer@index}] = {$answer}; 
{/foreach}

{*write question types to the page*}
{foreach $types as $type}
type[{$type@index}] = "{$type}";
{/foreach}

{* write the requried precision to the page for numerical questions *}
{foreach $questions as $question}
{if $types[$question@index] == "numerical"}
precision[{$question@index}] = {$question[0]};
{else}
precision[{$question@index}] = 0;
{/if}
{/foreach}

{*Determines if the selected answer is correct, and then displays the answer text if it is. Otherwise wrong answer is displayed.*}
function checkAnswers(){
	var correct = false;
	if(type[cur_question] == "multiselect"){
		if(document.getElementById("q"+cur_question).r1[answer[cur_question]].checked){
			correct=true;
		}
	}else if(type[cur_question] == "numerical"){
		{*see if we are within the required amount of precision of the answer for numerical questions*}
		if((parseFloat(document.getElementById("q"+cur_question).t1.value)).toPrecision(precision[cur_question]) == answer[cur_question].toPrecision(precision[cur_question])){
			correct=true;
		}
	}
	
	if(correct){
		if(first_time)
			correct_ft+=1;
		first_time=true;
		{*unhide the correct text*}
		document.getElementById("fd"+cur_question).style.display = "block";
		{*hide the check answer button*}
		document.getElementById("cans1").style.display = "none";
	}else{
		first_time=false;
		{*display the cross to show that the answer was incorrect*}
		document.getElementById("cross_img").style.display = "block";
	}
	{*change the number correct first time which is displayed*}
	document.getElementById("correctft1").innerHTML = "<br>Number correct first time: "+correct_ft+" / {$answers|count}"
	return false;
}

{*Movement to the next question is done by hiding the current question and 
making the next question which is hidden visable*}
function nextQuestion(){
	document.getElementById("d"+cur_question).style.display = "none";
	document.getElementById("fd"+cur_question).style.display = "none";
	cur_question+=1;
	if(cur_question < answer_len){
		document.getElementById("d"+cur_question).style.display = "block";
		document.getElementById("heading1").innerHTML="Question " + (cur_question + 1) + " of {$answers|count}:";
		document.getElementById("cans1").style.display = "block";
		document.getElementById("cross_img").style.display = "none";
	}else{
		document.getElementById("finish_screen").style.display="block";
		document.getElementById("heading1").innerHTML="Finished!";
	}
}
</script>

<div id="box">
<h3 id="heading1" >Question 1 of {$answers|count}:</h3>

{*text to display when the quiz is finished*}
<div id = "finish_screen" style="display: none">
Congratulations you are now a pulsar expert.<br><br>

Click here to go onwards:
<br><br>
<form action="{$nextpage}">
<input type="submit" value="Onwards">
</form>
</div>

{foreach $questions as $question}
{strip}


{*only make the first question visable*}
{if $question@index eq 0}
	<div id="d{$question@index}" style="display: block">
{else}
	<div id="d{$question@index}" style="display: none">
{/if}

<table>
<tr><td>
{$questions_text[$question@index]}

{if $types[$question@index] eq "multiselect"}

	{*print multiple choice question*}
	<form id="q{$question@index}">
		{foreach $question as $option}
			<input type="radio" name="r1" value="{$option}">{$option}<br>
		{/foreach}
	</form>

{elseif $types[$question@index] eq "numerical"}

	{*print numerical question*}
	 <br>
	<form id="q{$question@index}" onSubmit="false;">
		<input type="text" name="t1">(to {$question[0]} significant figure{if $question[0] > 1}s{/if})
	</form>

{/if}

{*if html was input into image_link for this question, display the html*}
</td><td>{if $image_link[$question@index] neq ""}{$image_link[$question@index]}{/if}</td></tr><tr><td>

</td></tr>
</table>

<br>

{*next question button, initially hidden*}
<div id="fd{$question@index}" style="display: none">
{$correct_text[$question@index]}
<form>
	<input type="button" onClick="nextQuestion()" value="Next Question."><img src="../images/tick.png">
</form>
</div>

</div>

{/strip}
{/foreach}

{*check answers block, visable until question is correctly answered*}
<div id="cans1" style="display: block">
<form>
<table>
<tr><td><input type="button" value="Check Answer" onClick="checkAnswers();"></td><td><div id="cross_img" style="display: none"><img src = "../images/cross.png">Try Again.</div></td></tr>
</table>
</form>
</div>

{*number of questions that the user has answered correctly the first time*}
<div id="correctft1">
<br>Number correct first time: 0 / {$answers|count}
</div>

