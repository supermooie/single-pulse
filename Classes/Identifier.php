<?php

define(IDS_FILE, 'ids.txt');

class Identifier
{
  // Checks to see if there is a valid ID set. If there isn't, create one, and
  // reload the page ($page).
  static public function Init($page)
  {
    $id = $_REQUEST['id'];

    if (!Identifier::IdExists($id)) {
      $id = Identifier::GenerateNewIdentifier();
      Identifier::AddId($id);

      header('Location: ' . WEB_ADDRESS . $page  . '?id=' . $id);
    }
  }

  static public function GetId()
  {
    return $_REQUEST['id'];
  }

  static public function IdExists($id)
  {
    // open id file
    //
    // if exists -> true
    //    else -> false

    //echo "looking for id: $id <br>";

    $found = FALSE;

    $file = fopen(IDS_FILE, 'r');

    while (!feof($file)) {
      $split = split(' ', fgets($file));
      $ids[] = trim($split[2]); // extract the id (3rd entry from left)
    }

    fclose($file);

    if (strlen($id) == 4) {
      if (in_array($id, $ids)) {
        $found = TRUE;
      }
    }

    return $found;
  }

  static public function GenerateNewIdentifier()
  {
    // generate id
    // return new id

    srand((double)microtime()*1000000); 
    $pass = '' ; 

    for ($i = 0; $i < 4; $i++) {
      $num = rand() % 33; 
      $tmp = substr(Identifier::$characters, $num, 1); 
      $id = $id . $tmp; 
    } 

    return $id;
  }

  // returns true if successfully added
  // returns false if id already exists
  static public function AddId($id)
  {
    // open id file
    //
    // if id already exists -> return error
    //    else -> add it

    if (!Identifier::IdExists($id)) { // if the id does not already exist, add it
      $date = date('Y-m-d-H:i:s'); // get date in YYYY-MM-DD-HH:mm:ss format
      $ip = $_SERVER['REMOTE_ADDR']; // get client's ip

      $line = $date . ' ' .
        $ip . ' ' .
        $id . "\n";

      $file = fopen(IDS_FILE, 'a');
      fwrite($file, $line);
      fclose($file);

      return TRUE;
    } else {
      return FALSE;
    }
  }

  static private $characters = "abcdefghijkmnopqrstuvwxyz023456789"; 
}

?>
