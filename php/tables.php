<?php
ini_set('display_errors', 1);

require_once('functions\retrieve.php');

session_start();

//session_destroy();
//$_SESSION['username'] = 'test';

if (isset($_POST["tables"])) {
    $selectedTable = $_POST["tables"];
} else {
    $selectedTable = "books";
}

$retrieveData = new retrieve;

/* @var $connection type connection class */
if ($retrieveData->conn != null) {
    $tables = $retrieveData->retrieveTables();
    $headers = $retrieveData->retrieveHead($selectedTable);
    $rows = $retrieveData->retrieveRows($selectedTable);
} else {
    $connection_error = "Problem with database connection";
}
?>

<!DOCTYPE HTML>
<html>
    <head>
        <title>PHP Design</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- CSS Styles -->
        <link href="../css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="../css/layout.css" rel="stylesheet" type="text/css">
        <link href="../css/datepicker.css" rel="stylesheet" type="text/css">
        <!-- End Styles -->

        <!-- Javascript -->
        <script src="../js/libaries/jquery-2.0.3.min.js"></script>
        <script src="../js/libaries/bootstrap.min.js"></script>
        <script src="../js/libaries/bootstrap-datepicker.js"></script>
        <script src="http://malsup.github.com/jquery.form.js"></script>
        <script src="../js/libaries/jquery.validate.min.js"></script>
        <!-- End JavaScript -->

    </head>

    <body>
        <div class="navbar navbar-inverse navbar-fixed-top">
            <div class="container">
                <div class="navbar-header" id="nav">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"> 
                        <span class="icon-bar"></span> <span class="icon-bar"></span> 
                    </button>
                    <a class="navbar-brand" href="#">Project name</a> </div>
                <div class="collapse navbar-collapse" id="nav">
                    <ul class="nav navbar-nav">
                        <li><a href="../index.html">Home</a></li>
                        <li class="active"><a href="tables.php">PHP Desgin</a></li>
                        <li><a href="http://localhost:4253/Default.aspx">ASP Desgin</a></li>
                    </ul>
                    <form class="login" action="functions/login.php" method="post">
                    <?php if (isset($_SESSION['username'])) { ?>
                    <ul class="nav navbar-nav pull-right">
                        <li style="color: white; margin-right: 10px; padding-top: 5px">
                            Hello <?php echo ucfirst($_SESSION['username']); ?>
                        </li>
                        <li>
                            <button type="submit" id="logoutBtn" class="btn btn-primary">Logout</button>
                        </li>
                    </ul>
                    <?php }else {?>
                    <div class="nav navbar-nav pull-right">
                        <ul class="nav navbar-nav pull-right">
                            <li class="login">
                                <input type="text" class="form-control" name="username" id="username" placeholder="Enter Username" required>
                            </li>
                            <li class="login">
                                <input type="password" class="form-control" name="password" id="password" placeholder="Enter Password" required>
                            </li>
                            <li class="login">
                                <button type="submit" id="loginBtn" class="btn btn-primary">Login</button>
                            </li>
                        </ul>
                        <ul style="list-style-type: none;">
                            <li>
                                <a class="register" data-toggle="modal" data-target="#registerModal" 
                                   href="#">Register</a>
                            </li>
                        </ul>         
                    </div>
                    <?php }?>
                    </form>
                </div>
                <!--/.nav-collapse --> 
            </div>
            <div class="login "id="login">
                    
            </div>
        </div>
        <div class="container_pageNav">
            <div class="error_reporting">
                <?php
                if (isset($connection_error)) {
                    echo $connection_error . "</br>";
                    echo $connection->connectError;
                    echo $connection->queryError;
                }
                ?>
            </div>
            <div class="tables">
                <form class="control" action="<?php echo $_SERVER['PHP_SELF']; ?>" method="post">
                    <div class="form_dropDown"> View Table:
                        <select name="tables" id="table" onchange="this.form.submit()">
                            <?php
                            while ($table = $tables->fetch()) {
                                if ($table->name == $selectedTable) {
                                    echo '<option value="' . $table->name . '" selected="selected">' . ucfirst($table->name) . '</option>';
                                } else {
                                    echo '<option value="' . $table->name . '">' . ucfirst($table->name) . '</option>';
                                }
                            }
                            ?>
                        </select>
                    </div>
                </form>
                <form class="tableControl" id="deleteStuff" action="functions/delete.php" method="post">
                    <input type="hidden" class="form-control" name="table" id="table" value="<?php echo $selectedTable ?>">
                    <div id="ajaxResponse3"></div>
                    <table class="table-bordered">
                        <tr >
                            <?php
                            if (isset($headers)) {
                                echo '<th class="data_head"></th>';
                                while ($head = $headers->fetch()) {

                                    if ($head->Field == "yearOfPub") {
                                        echo '<th class="data_head">Year of Publication</th>';
                                    } elseif ($head->Field == "yearOfRelease") {
                                        echo '<th class="data_head">Year of Release</th>';
                                    } else {
                                        echo '<th class="data_head">' . ucfirst($head->Field) . "</th>";
                                    }
                                }
                            }
                            ?>
                        </tr>
                        <?php
                        if (isset($rows)) {
                            while ($row = $rows->fetch()) {
                                echo "</tr>";
                                echo '<td><input type="radio" name="optionsRadios" class="optionsRadios" value="' . $row->imdb . '"></td>';
                                foreach ($row as $key => $value) {
                                    if ($key == 'cost') {
                                        echo "<td>&pound;" . $value . "</td>";
                                    } else {
                                        echo "<td>" . $value . "</td>";
                                    }
                                }
                                echo "</tr>";
                            }
                        }
                        ?>
                    </table>
                    </br>
                    <button type="button" class="btn btn-primary btn-lg" 
                            data-toggle="modal" data-target="#addModal">
                        <span class="glyphicon glyphicon-plus"></span> Add Values
                    </button>
                    <?php if (isset($_SESSION['username'])) { ?>
                    <button type="button" class="btn btn-primary btn-lg"
                            data-toggle="modal" data-target="#updateModal">
                        <span class="glyphicon glyphicon-cog"></span> Update Values
                    </button>
                    <button type="button" id="deleteBtn" class="btn btn-primary btn-lg" 
                            data-loading-text="Loading..." autocomplete="off">
                        <span class="glyphicon glyphicon-trash"></span> Delete Values
                    </button>
                    <?php } ?>
                </form>
            </div>

            <!-- Add Tables Data Modal -->
            <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title" id="myModalLabel">Add Values to <?php echo ucfirst($selectedTable) ?></h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group has-success" id="ajaxResponse"></div>
                            <form role="form" id="addForm" action="functions/add.php" method="post">
                                <div class="form-group">
                                    <input type="hidden" class="form-control" name="table" id="addTable" value="<?php echo $selectedTable ?>">
                                </div>
                                <?php if ($selectedTable == "books") { ?>
                                <div class="form-group">
                                    <label for="imdb">IMDB</label>
                                    <input type="number" class="form-control" name="imdb" id="imdbBook" placeholder="Enter IMDB" required>
                                </div>
                                <div class="form-group">
                                    <label for="name">Name</label>
                                    <input type="text" class="form-control" name="name" id="nameBook" placeholder="Enter Book Name" required>
                                </div>
                                <div class="form-group">
                                    <label for="author">Author</label>
                                    <input type="text" class="form-control" name="author" id="author" placeholder="Enter Author Name" required>
                                </div>
                                <div class="form-group">
                                    <label for="yearOfPub">Year of Publication</label>
                                    <input type="date" class="form-control" name="yearOfPub" id="yearOfPub" placeholder="Enter Book Publication Date" required>
                                </div>
                                <div class="form-group">
                                    <label for="cost">Cost</label>
                                    <div class="input-group">
                                        <span class="input-group-addon">&pound;</span>
                                        <input type="number" class="form-control" name="cost" id="costBook" placeholder="Enter Book Cost" required>
                                    </div>
                                </div>
                                <?php } else { ?>
                                <div class="form-group">
                                    <label for="imdb">IMDB</label>
                                    <input type="number" class="form-control" name="imdb" id="imdbDvd" placeholder="Enter IMDB" required>
                                </div>
                                <div class="form-group">
                                    <label for="name">Name</label>
                                    <input type="text" class="form-control" name="name" id="nameDvd" placeholder="Enter Book Name" required>
                                </div>
                                <div class="form-group">
                                    <label for="author">Director</label>
                                    <input type="text" class="form-control" name="director" id="directorDvd" placeholder="Enter Director Name" required>
                                </div>
                                <div class="form-group">
                                    <label for="yearOfPub">Year of Release</label>
                                    <input type="date" class="form-control" name="yearOfRelease" id="yearOfRelease" placeholder="Enter Book Release Date" required>
                                </div>
                                <div class="form-group">
                                    <label for="cost">Cost</label>
                                    <div class="input-group">
                                        <span class="input-group-addon">&pound;</span>
                                        <input type="number" class="form-control" name="cost" id="costDvd" placeholder="Enter Book Cost" required>
                                    </div>
                                </div>
                                <?php } ?>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal" >Close</button>
                            <button type="button" id="addSubmitBtn" class="btn btn-primary" data-loading-text="Loading..." autocomplete="off">Submit</button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
            
            <!-- Update Tables Data Modal -->
            <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title" id="myModalLabel">Update Values in <?php echo ucfirst($selectedTable) ?></h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group has-success" id="ajaxResponse2"></div>
                            <form role="form" id="updateForm" action="functions/update.php" method="post">
                                <div class="form-group">
                                    <input type="hidden" class="form-control" name="table" id="table" value="<?php echo $selectedTable ?>">
                                </div>
                                <?php if ($selectedTable == "books") { ?>
                                <div class="form-group">
                                    <label for="imdb">IMDB</label>
                                    <input type="number" class="form-control" name="imdb" id="imdbBook" placeholder="Enter IMDB" required>
                                </div>
                                <div class="form-group">
                                    <label for="name">Name</label>
                                    <input type="text" class="form-control" name="name" id="nameBook" placeholder="Enter Book Name" required>
                                </div>
                                <div class="form-group">
                                    <label for="author">Author</label>
                                    <input type="text" class="form-control" name="author" id="author" placeholder="Enter Author Name" required>
                                </div>
                                <div class="form-group">
                                    <label for="yearOfPub">Year of Publication</label>
                                    <input type="date" class="form-control" name="yearOfPub" id="yearOfPub" placeholder="Enter Book Publication Date" required>
                                </div>
                                <div class="form-group">
                                    <label for="cost">Cost</label>
                                    <div class="input-group">
                                        <span class="input-group-addon">&pound;</span>
                                        <input type="number" class="form-control" name="cost" id="costBook" placeholder="Enter Book Cost" required>
                                    </div>
                                </div>
                                <?php } else { ?>
                                <div class="form-group">
                                    <label for="imdb">IMDB</label>
                                    <input type="number" class="form-control" name="imdb" id="imdbDvd" placeholder="Enter IMDB" required>
                                </div>
                                <div class="form-group">
                                    <label for="name">Name</label>
                                    <input type="text" class="form-control" name="name" id="nameDvd" placeholder="Enter Book Name" required>
                                </div>
                                <div class="form-group">
                                    <label for="author">Director</label>
                                    <input type="text" class="form-control" name="director" id="director" placeholder="Enter Director Name" required>
                                </div>
                                <div class="form-group">
                                    <label for="yearOfPub">Year of Release</label>
                                    <input type="date" class="form-control" name="yearOfRelease" id="yearOfRelease" placeholder="Enter Book Release Date" required>
                                </div>
                                <div class="form-group">
                                    <label for="cost">Cost</label>
                                    <div class="input-group">
                                        <span class="input-group-addon">&pound;</span>
                                        <input type="number" class="form-control" name="cost" id="costDvd" placeholder="Enter Book Cost" required>
                                    </div>
                                </div>
                                <?php } ?>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal" >Close</button>
                            <button type="button" id="updateSubmitBtn" class="btn btn-primary" data-loading-text="Loading..." autocomplete="off">Submit</button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
            
            <!-- Register Modal -->
            <div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="registerLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title" id="myModalLabel">Register</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group has-success" id="ajaxResponseRegister"></div>
                            <form role="form" id="registerForm" action="functions/add.php" method="post">
                                <div class="form-group">
                                    <input type="hidden" class="form-control" name="table" id="table" value="users">
                                </div>
                                <div class="form-group">
                                    <label for="username">Username</label>
                                    <input type="text" class="form-control" name="username" id="username" placeholder="Enter Username" required>
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="text" class="form-control" name="password" id="password" placeholder="Enter Password" required>
                                </div>
                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="text" class="form-control" name="email" id="email" placeholder="Enter Email" required>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal" >Close</button>
                            <button type="button" id="registerBtn" class="btn btn-primary" data-loading-text="Loading..." autocomplete="off">Register</button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
        </div>
        <!-- /.container -->
    </body>
    <script src="../js/script.js"></script>
</html>
