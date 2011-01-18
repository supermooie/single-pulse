<?php
function read_info($filename){
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
