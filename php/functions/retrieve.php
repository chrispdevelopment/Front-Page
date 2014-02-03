<?php
require_once("dbFunctions.php");
class retrieve extends connection
{
    function __construct() {
        parent::__construct();
    }
    
    function retrieveTables()
    {
        $sqlTables = "SELECT * FROM table_list";
        $tables = $this->getRow($sqlTables);
        return $tables;
    }
    
    function retrieveHead($selectedTable)
    {
        $sqlHead = "SHOW COLUMNS FROM books." . $selectedTable;
        $headers = $this->getRow($sqlHead);
        return $headers;
    }
    
    function retrieveRows($selectedTable)
    {
        $sqlRows = "SELECT * FROM books." . $selectedTable;
        $rows = $this->getRow($sqlRows);
        return $rows;
    }
    
    function retrieveRow($selectedTable, $key)
    {
        if ($selectedTable === 'users')
        {
            $sqlRows = "SELECT * FROM books." . $selectedTable . " WHERE username = '" . $key . "'";
        }
        else {
            $sqlRows = "SELECT * FROM books." . $selectedTable . " WHERE imdb = " . $key;
        }
        
        $rows = $this->getRow($sqlRows);

        while ($eachRow = $rows->fetch())
        {
            $row = $eachRow;
            
        }
        return $row;
    }
}
?>