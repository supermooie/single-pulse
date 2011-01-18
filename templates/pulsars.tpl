{* Display pulse profiles for all PULSE@Parkes pulsars *}

{include file="header.tpl" title="Pulsars"}

{* Table of pulse profiles for each PULSE@Parkes pulsar *}

<div id="box">
<p> What you're looking at is the individual pulse data for a number of PULSE@Parkes pulsars. To make the next parts easier it is best to choose a pulsar with very obvious pulses. 
</div>
</br></br>

{section name=mysec loop=$pulsars}
{strip}

{if $pulsars[mysec].n_observations > 0}
<div id="pulsar_box">
<table class="gridtable">
<tr><th>{$pulsars[mysec].name}</th><tr>
<tr><td><a href="observation.php?id={$id}&pulsar={$pulsars[mysec].name_url}"><img src="{$pulsars[mysec].profile}" /></a></td></tr>

<tr><td align="center">
<table class="inner_gridtable">
<tr><td>Total Observations<td>{$pulsars[mysec].n_observations}</th><td>
</table>
</td></tr>
</table>
{/if}

</div>

{/strip}
{/section}

{include file="footer.tpl"}
