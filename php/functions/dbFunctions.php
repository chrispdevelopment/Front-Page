<?php

class connection {

    public $connectError;
    public $queryError;
    public $insertError;
    public $conn = null;
    private $DCONFIG_server = "localhost";
    private $DCONFIG_DBuser = "books";
    private $DCONFIG_DBpass = "10Banana$";
    private $DCONFIG_dbname = "books";

    function __construct() {
        $this->conn = $this->getConnection($this->DCONFIG_server, $this->DCONFIG_DBuser, $this->DCONFIG_DBpass, $this->DCONFIG_dbname);
    }

    function getConnection($server, $user, $pass, $dbName) {
        try {
            $conn = new PDO("mysql:host=$server;dbname=$dbName", $user, $pass);
            $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            $this->connectError = $e->getMessage();
        }
        return $conn;
    }

    function getRow($sql) {
        try {
            $queryPrep = $this->conn->prepare($sql);
            $queryPrep->setFetchMode(PDO::FETCH_OBJ);
            $queryPrep->execute();
        } catch (PDOException $e) {
            $this->queryError = $e->getMessage();
        }

        return $queryPrep;
    }

    function addUpdateDelRow($sql) {

        try {
            $queryPrep = $this->conn->prepare($sql);
            $queryPrep->execute();
        } catch (PDOException $e) {
            $this->insertError = $e->getCode();
            return false;
        }
        return true;
    }

    function sanitizeOne($var, $type) {
        switch ($type) {
            case 'int': // integer
                $var = mysql_real_escape_string((int) $var);
                break;

            case 'double': // integer
                $var = mysql_real_escape_string((double) $var);
                break;

            case 'str': // trim string
                $var = mysql_real_escape_string(trim($var));
                break;

            case 'nohtml': // trim string, no HTML allowed
                $var = mysql_real_escape_string(htmlentities(trim($var), ENT_QUOTES));
                break;

            case 'plain': // trim string, no HTML allowed, plain text
                $var = mysql_real_escape_string(htmlentities(trim($var), ENT_NOQUOTES));
                break;

            case 'upper_word': // trim string, upper case words
                $var = ucwords(strtolower(trim($var)));
                break;

            case 'ucfirst': // trim string, upper case first word
                $var = ucfirst(strtolower(trim($var)));
                break;

            case 'lower': // trim string, lower case words
                $var = strtolower(trim($var));
                break;

            case 'urle': // trim string, url encoded
                $var = urlencode(trim($var));
                break;

            case 'trim_urle': // trim string, url decoded
                $var = urldecode(trim($var));
                break;

            case 'telephone': // True/False for a telephone number
                $size = strlen($var);
                for ($x = 0; $x < $size; $x++) {
                    if (!((ctype_digit($var[$x]) || ($var[$x] == '+') || ($var[$x] == '*') || ($var[$x] == 'p')))) {
                        return false;
                    }
                }
                return true;

            case 'sql': // True/False if the given string is SQL injection safe
                return mysql_real_escape_string($var);
        }
        return $var;
    }

    //Example: sanitize($_GET, array( 'id'=>'int', 'name' => 'str') );
    function sanitize(&$data, $whatToKeep) {
        foreach ($whatToKeep as $key => $value) {
            $data[$key] = $this->sanitizeOne($data[$key], $value);
        }
        return $data;
    }

    function sanitizeData($dataArray, $table) {
        switch ($table) {
            case 'books':
                $dataArray = $this->sanitize($dataArray, 
                    array('imdb' => 'int', 'name' => 'str', 'author' => 'str',
                    'yearOfPub' => 'str', 'cost' => 'double',
                    'name' => 'ucfirst', 'author' => 'ucfirst'));
                return $dataArray;
            case 'dvds':
                $dataArray = $this->sanitize($dataArray, 
                    array('imdb' => 'int', 'name' => 'str', 'director' => 'str',
                    'yearOfRelease' => 'str', 'cost' => 'double',
                    'name' => 'ucfirst', 'director' => 'ucfirst'));
                return $dataArray;
            case 'stock':
                $dataArray = $this->sanitize($dataArray, 
                    array('imdb' => 'int', 'quantity' => 'int'));
                return $dataArray;
            case 'users':
                $dataArray = $this->sanitize($dataArray, 
                    array('username' => 'str', 'password' => 'str', 
                    'email' => 'str'));
                return $dataArray;
        }
    }

    function dateFormat($dataArray, $table) {
        switch ($table) {
            case 'books':
                foreach ($dataArray as $key => $value) {
                    if ($key === "yearOfPub") {
                        $dateValue = date_create_from_format('d/m/Y', $value);
                        $dataArray[$key] = (String)date_format($dateValue, 'Y-m-d');   
                        return $dataArray;
                    }
                }
            case 'dvds':
                foreach ($dataArray as $key => $value) {
                    if ($key === "yearOfRelease") {
                        $dateValue = date_create_from_format('d/m/Y', $value);
                        $dataArray[$key] = (String)date_format($dateValue, 'Y-m-d');
                        return $dataArray;
                    }
                }
            case 'users':
                foreach ($dataArray as $key => $value) {
                    if ($key === "dob") {
                        $dateValue = date_create_from_format('d/m/Y', $value);
                        $dataArray[$key] = (String)date_format($dateValue, 'Y-m-d');
                        return $dataArray;
                    }
                }
        }
    }

    function errors($errorCode) {
        switch ($errorCode) {
            case 23000:
                return "Record already exists";
        }
    }

}

?>
