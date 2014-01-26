<?php
 
/*
 * Following code will list all the ads
 */
 
 //URL para prueba
 //http://localhost/android_connect/lee_publicidad.php?tipo_loc_com=1
 
// array for JSON response
$response = array();

// include db connect class
require_once __DIR__ . '/db_connect.php';
 
// connecting to db
$db = new DB_CONNECT();
 
if (isset($_GET["tipo_loc_com"])) {
	$tipo_loc_com=$_GET["tipo_loc_com"];
	 
	// get all ads from ads table
	$result = mysql_query("SELECT 	A.*
FROM 	PUBLICIDAD A,
		LOCAL_COMERCIAL B, 
		LOCAL_COMERCIAL_TIPO C
WHERE 	A.LOCAL_COMERCIAL_ID = B.ID AND
		A.ESTADO = 1 AND
		A.FECHA_VENCIMIENTO >= NOW() AND
		B.LOC_COM_TIPO_ID = C.ID AND
		C.ID = $tipo_loc_com") or die(mysql_error());
	 
	// check for empty result
	if (mysql_num_rows($result) > 0) {
		// looping through all results
		// ads node
		$response["ads"] = array();
	 
		while ($row = mysql_fetch_array($result)) {
			// temp user array
			$ad = array();
			$ad["COD_PUBLICIDAD"] = $row["ID"];
			$ad["COD_LOCAL_COMERCIAL"] = $row["LOCAL_COMERCIAL_ID"];
			$ad["IMAGEN"] = $row["IMAGEN"];
			$ad["FECHA_REGISTRO"] = $row["FECHA_REGISTRO"];
			$ad["FECHA_VENCIMIENTO"] = $row["FECHA_VENCIMIENTO"];
			
			// push single ad into final response array
			array_push($response["ads"], $ad);
		}
		// success
		$response["success"] = 1;
	 
		// echoing JSON response
		echo json_encode($response);
		
	} else {
		// no ads found
		$response["success"] = 0;
		$response["message"] = "No ads found";
	 
		// echo no users JSON
		echo json_encode($response);
	}
} else {
	//No hay local comercial tipo como parametro
	$response["success"] = 0;
	$response["message"] = "No fields found";
}
?>