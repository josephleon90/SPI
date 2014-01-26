<?php
 
/*
 * Following code will get single USUARIO details
 * A USUARIO is identified by USUARIO id (usuario_login)
 */
 
 //URL Prueba
 //http://localhost/android_connect/login.php?usuario_login=&password_login=
 
// array for JSON response
$response = array();
 
// include db connect class
require_once __DIR__ . '/db_connect.php';
 
// connecting to db
$db = new DB_CONNECT();
 
// check for post data
if (isset($_GET["usuario_login"]) and isset($_GET["password_login"])) {
    $usuario_login = $_GET['usuario_login'];
	$password_login = $_GET['password_login'];
    // get a USUARIO from usuario table
    $result = mysql_query("SELECT * FROM USUARIO WHERE usuario_login = '$usuario_login' AND password_login = '$password_login' AND estado=1 AND tipo = 'USUARIO'");
 
    if (!empty($result)) {
        // check for empty result
        if (mysql_num_rows($result) > 0) {
 
            $result = mysql_fetch_array($result);
 
            $USUARIO = array();
            $USUARIO["COD_USUARIO"] = $result["ID"];
            $USUARIO["NOMBRE"] = $result["NOMBRE"];
            $USUARIO["APELLIDO"] = $result["APELLIDO"];
            $USUARIO["PLACA"] = $result["PLACA"];
            
            // success
            $response["success"] = 1;
 
            // USUARIO node
            $response["USUARIO"] = array();
 
            array_push($response["USUARIO"], $USUARIO);
 
            // echoing JSON response
            echo json_encode($response);
        } else {
            // no USUARIO found
            $response["success"] = 0;
            $response["message"] = "No USUARIO found";
 
            // echo no users JSON
            echo json_encode($response);
        }
    } else {
        // no USUARIO found
        $response["success"] = 0;
        $response["message"] = "No USUARIO found";
 
        // echo no users JSON
        echo json_encode($response);
    }
} else {
    // required field is missing
    $response["success"] = 0;
    $response["message"] = "Required field(s) is missing";
 
    // echoing JSON response
    echo json_encode($response);
}
?>