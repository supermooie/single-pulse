{include file="header.tpl" title="Module Three: Period finder"}
<script type="text/javascript">
function calc_period(){
	var fp = document.getElementById("fp").value;
	var sp = document.getElementById("sp").value;
	var np = document.getElementById("np").value;
	if(np == 0){
		np = 1;
	}
	if(fp > sp){
		var t = fp;
		fp = sp;
		sp = t;
	}
	document.getElementById("form_period").value = Math.round((sp - fp)/np * 100000)/100000.0;
	return true;
}
</script>

<div id="box">
<h3>Period finder: {$pulsar}</h3>
Determine an approximate value for the period of the pulsar by selecting two pulses and then counting the number of periods between the two pulses. Initially, all the data collected during the observation you selected will be displayed, you will probably need to zoom in to see the individual pulses. 

<table>
<tr>
<td><img src="{$plot_img}"></td>

<td>

<table>
<form action="" method="POST">
{*<input type="hidden" name="first_pulse" value="{$first_pulse}">
<input type="hidden" name="second_pulse" value="{$second_pulse}">
<input type="hidden" name="num_pulse" value="{$num_pulse}">*}
<tr><td></br></td></tr>
<tr><td><h3>Zoom: </h3></td></tr>
<tr><td> Select a range along the x-axis to view. Inputting both start and end times as zero will reset the view. </td></td>
<tr><td></td><tr>
<tr> <td>Zoom start: </td><td><input type="text" name="szoom" value="{$szoom}"> </td><td>seconds</td> </tr>
<tr> <td>Zoom end: </td><td><input type="text" name="ezoom" value="{$ezoom}"> </td><td>seconds</td></tr>
<tr><td><input type="submit" value="Zoom"></td>{*</form>*}</tr>
<tr><td></br></td></tr>
<tr><td><h3>Add Pulse Positions: </h3></td></tr>
<tr><td> Enter the information required to calculate the period. </td></td>
<tr><td></td><tr>
<tr>{*<form action="" method="POST">*}
<td>First pulse position: </td><td> <input type="text" name="first_pulse" value="{$first_pulse}" id="fp"></td> <td>seconds
{*<input type="hidden" name="second_pulse" value="{$second_pulse}">
<input type="hidden" name="num_pulse" value="{$num_pulse}">
<input type="hidden" name="szoom" value="{$szoom}">
<input type="hidden" name="ezoom" value="{$ezoom}">*}
</td><td>{*<input type="submit" value="Save">*}</td>
{*</form>*}</tr>
<tr>{*<form action="" method="POST">*}
<td>Second pulse position: </td><td> <input type="text" name="second_pulse" value="{$second_pulse}" id="sp"></td><td> seconds
{*<input type="hidden" name="first_pulse" value="{$first_pulse}">
<input type="hidden" name="num_pulse" value="{$num_pulse}">
<input type="hidden" name="szoom" value="{$szoom}">
<input type="hidden" name="ezoom" value="{$ezoom}">*}
</td><td>{*<input type="submit" value="Save">*}</td>
{*</form>*}</tr>
<tr>{*<form action="" method="POST">*}
<td>Number of pulse periods: </td><td> <input type="text" name="num_pulse" value="{$num_pulse}" id="np"> 
{*<input type="hidden" name="second_pulse" value="{$second_pulse}">
<input type="hidden" name="first_pulse" value="{$first_pulse}">
<input type="hidden" name="szoom" value="{$szoom}">
<input type="hidden" name="ezoom" value="{$ezoom}">*}
</td><td>{*<input type="submit" value="Save">*}</td>
</form></tr>
<tr><td></br></td></tr>
<tr><td> <h3> Pulse Positions: </h3> </td></td>
<tr><td> Information required to calculate the period that you currently have saved. </td></td>
<tr><td></td><tr>
<tr><td> First pulse position: {$first_pulse}</td> </tr>
<tr><td> Second pulse position: {$second_pulse}</td> </tr>
<tr><td> Number of pulses: {$num_pulse}</td> </tr>
<tr><td> </br></td></tr>
<tr><td> <form action="fold_intro.php?id={$id}&pfname={$pfname}&pulsar={$pulsar}" method="POST" onSubmit="calc_period();"> 
<input type="hidden" name="period" id="form_period"value="{math equation="(x-y)/z" x=$second_pulse y=$first_pulse z=$num_pulse_safe}">
<input type="submit" value="Calculate Period"></form></td></tr>
</table>

</td>

</tr>
</table>

To Calculate the period you can:
<ol>
<li>Zoom in on a range where you can see 10-15 pulses</li>
<li>Count the number of full periods between the left most and right most pulses you can see on the screen</li>
<li>Enter the number of periods you measure</li>
<li>Zoom in on the left most pulse until you can clearly see its position on the x-axis. Make sure that you get the pulse position (in seconds) to at least 2 decimal places.</li>
<li>Repeat part 4 for the right most pulse</li>
<li>Click the "Calculate Period" button</li>
</ol>

{include file="footer.tpl"}
