{* Display pulse profiles for all observations of a pulsar *}

{include file="header.tpl" title=${pulsar_name}}

<div id="box">
<p> Displayed below are plots of previous {$pulsar_name} individual pulse observations. Each plot should show around 10 pulses. If you cant see these pulses it is probably because the pulsar is "off" or because the pulsar is too faint to be seen above the noise level.

</div>

<div id="box">
{section name=mysec loop=$observations}
{strip}

<div id="pulsar_box">
<table class="gridtable">
<tr><th>{$observations[mysec].filename}</th><tr>
<tr><td align="center"><a href="findperiod_intro.php?id={$id}&pulsar={$pulsar_name_url}&pfname={$observations[mysec].filename|urlencode}"><img src="{$observations[mysec].profile}" /></a></td></tr>

<tr>{*<td align="center">
<table class="inner_gridtable">
<tr><td>MJD (days)</td><td>{$observations[mysec].MJD}</td></tr>
<tr><td>Period (ms)</td><td>{$observations[mysec].period}</td></tr>
<tr><td>Period Error (ms)</td><td>{$observations[mysec].period_error}</td></tr>
</table>
</td>*}</tr>

</table>
</div>

{/strip}
{/section}
</div>

{include file="footer.tpl"}
