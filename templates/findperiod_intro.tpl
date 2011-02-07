{include file="header.tpl" title="Module Three: Find Period Introduction"}

<div id="box">
<h3>Working out the Period: {$pulsar}</h3>
One method of obtaining an estimate for the pulsars period is to select two pulses which are separated by around 10 to 20 pulses. Using the time position of both of these pulses and a count of the number of periods in-between we can calculate a fairly accurate average period using the equation:
<br/>
P = (t2 - t1) / N
<br/>

<table>
<tr>
<td>where:</td><td>P is the period</td> </tr>
 		<tr><td></td><td>N is the number of periods between the two selected pulses</td></tr>
 		<tr><td></td><td>t2 is the time position of the later pulse</td></tr>
 		<tr><td></td><td>t1 is the time position of the earlier pulse</td></tr>
</table>

<br/>
For example in the image below N = 5, t1 = 10.07, t2 = 10.97:
<br/>
<img WIDTH=340 HEIGHT=260 src="images/period_find_how.png">
</br>

<p> Click 'Continue' to begin.

</div>

<p> <a class="button" href="findperiod.php?id={$id}&pulsar={$pulsar}&pfname={$pfname|urlencode}"><span>Continue</span></a>

{include file="footer.tpl"}
