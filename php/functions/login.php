<?php

require_once("retrieve.php");

class login extends retrieve {
    public $username;
    private $password;
    
    function __construct($postData) 
    {
        parent::__construct();
        
        $this->username = $postData['username'];
        $this->password = $postData['password'];
        
        $this->username = $this->sanitizeOne($this->username, 'str');
        $this->password = $this->sanitizeOne($this->password, 'str');
        
        $this->password = $this->hashPassword($this->password);
    }
    
    function hashPassword ($password)
    {
        $password = hash("sha512", $password);
        
        return $password;
    }
    
    function authCheck ()
    {
        $row = $this->retrieveRow('users', $this->username);
        print_r($row);
        
        if ($row->username === $this->username && 
                $row->password === $this->password) {
            return true;
        } else {
            return false;
        }
    }
}

session_start();

if (isset($_SESSION['username'])) {
    session_destroy();
    header("Location: ../tables.php") ;
} else {
    $login = new login ($_POST);

    if ($login->authCheck()) {
        $_SESSION['username'] = $login->username;
        header("Location: ../tables.php?login=true") ;
    } else {
        header("Location: ../tables.php?login=false") ;
    }
}
?>