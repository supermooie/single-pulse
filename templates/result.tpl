{include file="header.tpl" title="Module Three: Folding Introduction"}

<div id="box">
<h1>Results for {$pulsar}</h1>
</br>
<font size="5">
The period you calculated was: {$period_color} sec</br>
<br/>
The period in the pulsar catalog is: {$period_correct} sec
<br/>
<br/>
The difference is: {$pdiff}
</font>
<br/><br/>
<h4>Using your value for the period we find that:</h4>
<br/>
The frequency of the pulsar is: {if $period neq 0} {math equation="round(1/x,4)" x=$period} Hz {else} Undefined. {/if}
<br/>
The velocity of the surface of the pulsar is (assuming a radius of 12km): {if $period neq 0} {math equation="round(2*3.1415926*12/ (x * 300000) * 100, 4)" x=$period} {else} 0 {/if}% the speed of light.
<br/><br/>
Your folded pulse profile is:<br/>
<img src="{$plot_img}"><br><br>
Here is a short animation of the folding using the period you calculated:<br>
<img src="{$fold_ani}">

{include file="footer.tpl"}
