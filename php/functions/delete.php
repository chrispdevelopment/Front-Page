<?php
require_once("dbFunctions.php");

class delete extends connection {

    private $dataArray;
    private $table;
    public $sqlQuery;

    function __construct($dataArray, $table) {
        parent::__construct();
        $this->dataArray = $dataArray;
        $this->table = $table;
    }

    function sqlPrep() {
        if ($this->table === 'users') {
            $this->sqlQuery = "DELETE FROM " . $this->table . " WHERE username = " .
                    $this->dataArray['optionsRadios'];
        } else {
            $this->sqlQuery = "DELETE FROM " . $this->table . " WHERE imdb = " .
                    $this->dataArray['optionsRadios'];
        }
    }

}

$delete = new delete($_POST, $_POST['table']);

$delete->sqlPrep();

//print_r($_POST);
if ($delete->addUpdateDelRow($delete->sqlQuery)) {
    echo "Succesfully Deleted";
} else {
    echo $delete->errors($delete->insertError);
}
?>


?>