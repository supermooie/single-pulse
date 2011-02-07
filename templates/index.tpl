{* Introductory web page for Module Three. A unique ID should be created. *}

{include file="header.tpl" title="Module Three: Introduction"}

<div id="box">
<h3>Introduction</h3>

The pulses emitted by pulsars to occur at regular time intervals. That is the pulses exhibit a constant period. The pulse period is defined as the time difference between adjacent pulses, as shown in the image below. In this module it is your job to accurately determine the period of a pulsar.
<br/>
<center><img WIDTH=340 HEIGHT=260 src="images/period_example.png"></center>
<br/>
As you can see in the example above each of the individual pulses has a different shape and height. Most of the time we are not interested in the appearance of each individual pulse instead we want to know what the “average” pulse looks like. Using the period you calculate we will be able to fold a large number of individual pulses together to build a picture of the average pulse. To get the average pulse profile we break the data into time blocks with a width of the pulse period, so that only one pulse appears in each time block, as shown in the image below.
<br/>
<center><img WIDTH=340 HEIGHT=260 src="images/period_block_example.png"></center>
<br/>
We then take each of the time blocks and add them all together to make a single average pulse profile (often called a folded pulse profile). The small animation below shows how the folded pulse profile changes a more pulses are added to the profile. This animation was generated using a pulsar that is much weaker than the one above, meaning that it is hard to see the individual pulses.
<br/>
<center><img WIDTH=340 HEIGHT=260 src="images/fold_ani.gif"></center>
<br/>
Notice that the noise becomes smaller as the number of pulses added increases, while the pulse becomes more distinct. Why doesn't the noise increase when we add more pulses?
<p> Click 'Continue' to get started.

</div>

<p> <a class="button" href="pulsars.php"><span>Continue</span></a>

{include file="footer.tpl"}
