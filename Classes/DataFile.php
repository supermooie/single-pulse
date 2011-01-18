<?php


/**
 * Static class which handles the reading/writing for a single (for now)
 * data file for an observation.
 */
class DataFile
{
  /**
   * Gets observation parameters from the DataFile($filename). Returns a
   * stdClass instance with the following values:
   *    - period
   *    - period_error
   *    - MJD
   */
  public static function GetValues($filename)
  {
    // TODO: check if file exists. Throw exception if necessary.

    $values = new stdClass();

    // TODO: check if file exists
    $fh = @fopen($filename, 'r');
    if ($fh) {
      while (!feof($fh)) {
        $buffer = fgets($fh, 4096);
        $arr = explode(' ', $buffer);

        $key = trim($arr[0]);
        $value = trim($arr[1]);

        switch ($key) {
        case 'MJD:':
          $values->MJD = $value;
          break;
        case 'Period:':
          $values->period = $value;
          break;
        case 'Period_Error:':
          $values->period_error = $value;
          break;
        }
      }
      fclose($fh);
    }

    return $values;
  }
};

?>
