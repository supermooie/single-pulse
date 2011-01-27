<?php

/**
 * Define necessary Smarty folders and various config options
 * required for Module Two to run.
 *
 * Author: Jonathan Khoo
 * Date:   07.10.10
 */

define('SMARTY_DIR', './smarty/libs/');
define('SMARTY_TEMPLATE_DIR', './templates/');

// Directory on herschel (must be writable by the web server).
define('SMARTY_COMPILE_DIR', './templates_c/');

// Directory (on herschel) where Module Two resides.
define('ROOT_DIR', '/var/www/vhosts/pulseatparkes.atnf.csiro.au/htdocs/single_pulse/');

// Web address of Module Two.
define('WEB_ADDRESS', 'http://pulseatparkes.atnf.csiro.au/single_pulse/');

// Directory (on disk) where all PULSE@Parkes observations are kept.
define('OBSERVATIONS_ROOT_DIR', '/pulsar/archive13/pulseATpks/Observations/');

// Directory (on disk) where all PULSE@Parkes observations are kept.
define('OBSERVATIONS_DIR', OBSERVATIONS_ROOT_DIR."Search/");

define('WEB_OBSERVATIONS_ADDRESS', 'http://pulseatparkes.atnf.csiro.au/Observations/Search/');

// Extension for thumbnail images.
define('SMALL_PROFILE_EXT', 'sm.png');

// Directory (on herschel) for session data. Information, results, plots, etc.
define('SESSION_DIR', ROOT_DIR.'session/');

define('WEB_SESSION_ADDRESS', WEB_ADDRESS.'session/');

// Directory where text files storing questions are found
define('QUESTIONS_DIR', ROOT_DIR.'questions/');

// Directory for binary files
define('BIN_DIR', ROOT_DIR.'bin/');

define('MILLISECONDS_IN_A_SECOND', 1000);

define('SECONDS_IN_DAY', 86400);

require_once SMARTY_DIR . 'Smarty.class.php'

?>
