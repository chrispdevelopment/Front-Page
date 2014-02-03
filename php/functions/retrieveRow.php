<?php

require_once("retrieve.php");

class retrieveRow extends retrieve {
    public $row;
    
    function __construct() {
        parent::__construct();
    }
    
    function passBack($selectedTable, $key)
    {
        $row = $this->retrieveRow($selectedTable, $key);
        
        return $row;
    }
}

$printBack = "";

$retrieveRow = new retrieveRow;

$result = $retrieveRow->passBack($_POST['table'], $_POST['key']);

foreach($result as $key => $value)
{
    if ($key === 'yearOfPub' || $key === 'yearOfRelease' || $key === 'dob')
    {
        $dateValue = date_create($value);
        $value = (String)date_format($dateValue, 'd/m/Y');
    }
    
    $printBack .= $value . "|";
}

echo $printBack;
?>