<?php
/*read a info file containing info such as pulsar period, mjd of detection etc
file of form:
key: value
Loads the file into a map (associative array)
*/
function read_info($filename){
	if(!file_exists($filename)) return array();
	$fin = file($filename);
	for($i=0;$i<count($fin);$i++){
		$lne = explode(" ", $fin[$i]);
		if($lne[0][count($lne[0])] == ":")
			$lne[0] = substr($lne[0], 0, -1);
		$ret[$lne[0]] = $lne[1];
	}
	return $ret;
}
?>
