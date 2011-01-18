{* Introductory web page for Module Two. A unique ID should be created. *}

{include file="header.tpl" title="Module Three: Folding"}

<h3>Improve the fold: {$pulsar}</h3>

<table>
<tr>

<td><img src="{$plot_img}"></td>
<td><table>

<form action="" method="POST">
<tr> <td>Folding Period:</td><td><input type="text" name="period" value="{$period}"></td> </tr>
<tr> <td><input type="submit" value="New Period"></td></tr>
</form>
</table>
<br/>
<table>
<form action="result.php?id={$id}&pulsar={$pulsar}&pfname={$pfname|urlencode}" method="POST">
<tr><td>Click here when you have a good estimate for the period:</td></tr>
<input type="hidden" name="period" value="{$period}">
<tr><td><input type="submit" value="Done"></td></tr>
</form>
<tr><td>
</table>


</td> </tr> </table>

Try changing the period in the text box above and then clicking the New Period button to see if you can get something which looks like the image above. This can often be very tricky. You may use any method you wish but it might be good to:
<ol>
<li>Delete decimal places from the end of your answer until you can't see the peak any more, then append the next decimal place so you can see the peak</li>
<li>Add or subtract one from the last decimal place and see if it makes the peak sharper or broader, keep doing this until the peak starts getting broader</li>
<li>When you think you have the best value for the last decimal place, try both adding and subtracting 0.5 from the last decimal place (if for example your number is 0.1784 try the new periods of 0.17835 and 0.17845). Choose the best of these two.</li>
<li>Repeat from step 2 until changing the last decimal place doesn't seem to have any effect on the pulse.</li>
</ol>

{include file="footer.tpl"}
