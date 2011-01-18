{* Introductory web page for Module Two. A unique ID should be created. *}

{include file="header.tpl" title="Module Three: Folding Introduction"}

<div id="box">
<h2>The period you calculated was: {$period}</h2>
<h3>Improving the period accuracy: {$pulsar}</h3>
You have now determined an estimate for the period, however we can do better. Earlier in this module the concept of folding individual pulses to produce an average pulse profile was introduced. You might remember that the method for folding the pulses involved dividing the pulses up into time blocks with a width of the period. If the value of the period we are using is just a little bit wrong then the folded profile is going to look very wrong because the small error is compounded over hundreds or even thousands of pulses.

If your period from the last part of the module was sufficiently accurate you should get an average pulse profile which looks something like one of these images (don't worry if the pulse is in a different position):

<br/>
<center><img WIDTH=340 HEIGHT=260 src="images/fold_ok1.gif"><img WIDTH=340 HEIGHT=260 src="images/fold_ok2.gif"></center>
<br/>

However if you don't get a distinct pulse like in the images above then you need to go back an do the last part of the module more carefully. Make sure you check that in the last part of the module you counted the number of periods not the number of pulses between the two pulses you selected.

A very good period should give an average pulse profile that looks something like the image below, although it will differ from pulsar to pulsar.

<br/>
<center><img WIDTH=340 HEIGHT=260 src="images/fold_good.gif"></center>
<br/>

An image like the one above is the aim of this part of the module. Try changing the period in the text box on the next page and then clicking the New Period button to see if you can get something which looks like the image above. This can often be very tricky. You may use any method you wish but it might be good to:
<ol>
<li>Delete decimal places from the end of your answer until you can't see the peak any more, then append the next decimal place so you can see the peak</li>
<li>Add or subtract one from the last decimal place and see if it makes the peak sharper or broader, keep doing this until the peak starts getting broader</li>
<li>When you think you have the best value for the last decimal place, try both adding and subtracting 0.5 from the last decimal place (if for example your number is 0.1784 try the new periods of 0.17835 and 0.17845). Choose the best of these two.</li>
<li>Repeat from step 2 until changing the last decimal place doesn't seem to have any effect on the pulse.</li>
</ol>

<p> Click 'Continue' to begin.

</div>

<form action="fold.php?id={$id}&pulsar={$pulsar}&pfname={$pfname|urlencode}" method="POST">
<input type="hidden" name="period" value="{$period}">
<input type="submit" value="Continue">
</form>

{include file="footer.tpl"}
