<?php

require_once("dbFunctions.php");

class update extends connection {

    private $dataArray;
    private $table;
    public $sqlQuery;

    function __construct($dataArray, $table) {
        parent::__construct();
        $this->dataArray = $dataArray;
        $this->table = $table;
        $this->sanitizeAddData();
    }

    function sanitizeAddData() {
        $this->table = $this->sanitizeOne($this->table, 'str');
        $this->dataArray = $this->sanitizeData($this->dataArray, $this->table);
    }

    function sqlPrep() {
        $count = 0;
        $values = "";
        
        $this->dataArray = $this->dateFormat($this->dataArray, $this->table);

        foreach ($this->dataArray as $key => $value) {
            if ($count === 0) {
                
           } elseif ($count === 1) {
                $values .= $key . "='" . $value . "'";
            } else {
                $values .= ", " . $key . "='" . $value . "'";
            }
            $count++;
        }

        if ($this->table === 'users') {
            $this->sqlQuery = "UPDATE " . $this->table . " SET " . $values .
                    " WHERE username = " . $this->dataArray['username'];
        } else {
            $this->sqlQuery = "UPDATE " . $this->table . " SET " . $values .
                    " WHERE imdb = " . $this->dataArray['imdb'];
        }
    }
}

$update = new update($_POST, $_POST['table']);

$update->sqlPrep();

if ($update->addUpdateDelRow($update->sqlQuery)) {
    echo "Succesfully Updated";
} else {
    echo $update->insertError;
}
?>