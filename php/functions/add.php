<?php

require_once("dbFunctions.php");

class add extends connection {

    private $dataArray;
    public $table;
    public $sqlQuery;

    function __construct($dataArray, $table) {
        parent::__construct();
        $this->dataArray = $dataArray;
        $this->table = $table;
        
        if ($this->table == 'users') {
            $this->dataArray['password'] = 
                    $this->hashPassword($this->dataArray['password']);
        }
        
        $this->sanitizeAddData();
    }

    function sanitizeAddData() {
        $this->table = $this->sanitizeOne($this->table, 'str');
        $this->dataArray = $this->sanitizeData($this->dataArray, $this->table);
    }
    
    function hashPassword ($password)
    {
        $password = hash("sha512", $password);
        
        return $password;
    }

    function sqlPrep() {
        $count = 0;
        $columnNames = "";
        $columnValues = "";
        
        if ($this->table == 'books' || $this->table === 'dvds') {
            $this->dataArray = $this->dateFormat($this->dataArray, $this->table);
        }
        foreach ($this->dataArray as $key => $value) {
            if ($count === 0) {} 
            elseif ($count === 1) {
                $columnNames .= $key;
                $columnValues .= "'" . $value . "'";
            } else {
                $columnNames .= ", " . $key;
                $columnValues .= ", '" . $value . "'";
            }
            $count++;
        }
        $this->sqlQuery = "INSERT INTO " . $this->table . " (" . $columnNames . ") "
                . "VALUES (" . $columnValues . ")";
    }

}

$test = array(
    "test" => "test",
    "test2" => "test2",
    "test3" => "test3"
);

$add = new add($_POST, $_POST['table']);

$add->sqlPrep();

if ($add->addUpdateDelRow($add->sqlQuery))
{
    if ($add->table == 'users') {
        echo "Succesfully Registered";
    } else {
        echo "Succesfully Inserted";
    }
}
else{
    echo $add->errors($add->insertError);
    echo "b";
}
?>