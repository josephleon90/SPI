<?php
 
/*
 * Following code will create a new reservation row
 * All reservation details are read from HTTP Post Request
 */
 //URL para prueba
 //http://localhost/android_connect/reserva_parqueaderos.php?cod_parqueo=1&cod_garaje=1&cod_usuario=1&fecha_reservacion=20140109
 
// array for JSON response
$response = array();
 
// check for required fields
if (isset($_GET['cod_parqueo']) && isset($_GET['cod_garaje']) && isset($_GET['cod_usuario']) && isset($_GET['fecha_reservacion'])) {
 
    $cod_parqueo = $_GET['cod_parqueo'];
    $cod_garaje = $_GET['cod_garaje'];
    $cod_usuario = $_GET['cod_usuario'];
	//$fecha_reservacion = $_GET['fecha_reservacion'];
	$fecha_reservacion = date("Y-m-d H:i:s", strtotime($_GET["fecha_reservacion"])); 
    // include db connect class
    require_once __DIR__ . '/db_connect.php';
 
    // connecting to db
    $db = new DB_CONNECT();
 
    // mysql inserting a new row
	

    $result = mysql_query(	"INSERT INTO 
							RESERVACION(cod_parqueo, 
										cod_garaje, 
										cod_usuario, 
										fecha_registro, 
										fecha_reservacion, 
										estado ) 
							VALUES (
										'$cod_parqueo',  
										'$cod_garaje',  
										'$cod_usuario', 
										NOW( ) ,  
										'$fecha_reservacion', 
										1 )");
 
    // check if row inserted or not
    if ($result) {
        // successfully inserted into database
        $response["success"] = 1;
        $response["message"] = "Reservacion creada exitosamente.";
 
        // echoing JSON response
        echo json_encode($response);
    } else {
        // failed to insert row
        $response["success"] = 0;
        $response["message"] = "Oops! Un error ocurrio.";
 
        // echoing JSON response
        echo json_encode($response);
    }
} else {
    // required field is missing
    $response["success"] = 0;
    $response["message"] = "Campos requeridos estan perdidos";
 
    // echoing JSON response
    echo json_encode($response);
}
?>