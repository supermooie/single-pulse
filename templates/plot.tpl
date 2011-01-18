{* Display various plots for observations of a pulsar *}

{include file="header.tpl" title={$pulsar_name}}

<div id="box">
<div id="pulsar_box">
<img id="plot" src="session/period_vs_mjd_{$id}.png"/>
</div>

{*
<div id="pulsar_box">
<table class="gridtable">
<tr><td>Period Derivative (s/day)</td><td>{$period_derivative_days}</td></tr>
<tr><td>Period Derivative (s/s)</td><td>{$period_derivative_seconds}</td></tr>
<tr><td>Pulsar Age(s)</td><td>{$pulsar_age_seconds}</td></tr>
<tr><td>Pulsar Age(Myr)</td><td>{$pulsar_age_megayear}</td></tr>
</table>
</div>
*}

<div id="box">
<p> Enter values for m and b here:
<p> y = <input type="textbox" value="" id="m" name="m" size="20"/> x + <input type="textbox" value="" id="b" name="b" size="5"/>
<p> <a class="button" id="plot_submit" href=""><span>Plot</span></a>
</div>

{* Detail the process of how to calculate the pulsar's age *}
<div id="box">
<h3>Calculating the Age of {$pulsar_name}</h3>

<p>As mention previously, the method we're going to use in order to calculate the distance to {$pulsar_name} is:

<pre> age(s) = P(s) / 2 * pDot(s) </pre>

<p>Each vertical red line corresponds to an observation. The line denotes the period of {$pulsar_name} and period error at the time directly below on the x-axis corresponding to the time of the observation.

<p>The gradient of the blue line is {$period_derivative_days}. Recall that the units used to calculate this gradient was days and seconds. (I KNOW IT'S NOT YET, BUT IT WILL BE.)

<p>Also from school, you may have also heard of the equation of a straight line

<pre> y = mx + b </pre>

<p>We can use this equation calcalate the value of pDot(s). Recall that we have the periods of {$pulsar_name} plotted along the y-axis (the red lines) and how we have MJD (time) along the x-axis. We can substitute these variables to get:

<pre> P(s) = mt + c </pre>

<p>And notice that (NEED MORE WORDS HERE!):

<pre>pDot(s) = m </pre>

<p>Since pDot needs to be in seconds, let's convert it. (Hint: how many seconds are there in a day?)

<p><i>Students to multiply original number by 86400. Add text field entry in here - calculate how close they were. Only allow them to continue (hide the following text?) if they're within a certain threshold.</i>

<p>Well done on successfully converting from seconds per day to seconds per seconds and determining the value of pDot(s)!

<p>In the initial formula to calculate a pulsar's age, we can substitude any observed period (in seconds) and determine the age to {$pulsar_name}.

<pre> age(s) = A random period(s) / 2 * {$period_derivative_seconds} </pre>

Once again, having a length amount of time in seconds isn't such a great unit. Let's convert our age (in seconds) into an age in megayears. (Hint: how many seconds are there in a year?)

<p><i>Students to multiply original number by 86400 * 365.24 * 10^6. Add text field entry in here - calculate how close they were.</i>

</div>


<div id="box">
<img src="session/period_vs_mjd_line_removed_{$id}.png"/>
</div>

{include file="footer.tpl"}
