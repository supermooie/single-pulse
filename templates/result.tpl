{* Introductory web page for Module Two. A unique ID should be created. *}

{include file="header.tpl" title="Module Three: Folding Introduction"}

<div id="box">
<h1>Results for {$pulsar}</h1>
</br>
<font size="5">
The period you calculated was: {$period_color} sec</br>
<br/>
The period in the pulsar catalog is: {$period_correct} sec
</font>
<br/><br/>
<h4>Using your value for the period we find that:</h4>
<br/>
The frequency of the pulsar is: {math equation="1/x" x=$period} Hz
<br/>
The velocity of the surface of the pulsar is (assuming a radius of 12km): {math equation="round(2*3.1415926*12/ (x * 300000) * 100, 4)" x=$period}% the speed of light.
<br/><br/>
Your folded pulse profile is:<br/>
<img src="{$plot_img}">

{include file="footer.tpl"}
