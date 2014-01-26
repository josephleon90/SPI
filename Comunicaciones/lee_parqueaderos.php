<?php

/*
 * Following code will list all the garajes
 */
 //Url para prueba
 //http://localhost/android_connect/lee_parqueaderos.php?pos_gps=-2.192589,-79.896337
 
// array for JSON response
$response = array();
$garajes = array();
 
// include db connect class
require_once __DIR__ . '/db_connect.php';
 
// connecting to db
$db = new DB_CONNECT();

if (isset($_GET["pos_gps"])) {
	
	// get all garajes from garajes table
	$result = mysql_query("
SELECT 	A.ID,
		A.COD_CLIENTE,
		A.DESCRIPCION,
		A.NUM_PISOS,
		A.NUM_PARQUEOS,
		A.DIRECCION,
		A.DIRECCION_CORD,
		B.ID AS ID_PARQUEO,
		B.COD_DESCRIPCION,
		B.PISO
FROM 	GARAJE A, PARQUEO B
WHERE	A.ID = B.COD_GARAJE AND
		A.ESTADO = 1 AND
		B.ESTADO = 1 AND
		B.ID NOT IN (SELECT 	C.ID 
                              FROM 		RESERVACION  C
                              WHERE 	C.FECHA_RESERVACION + INTERVAL 10 MINUTE >= NOW() AND 
                              			C.ESTADO=1 )
										
										") or die(mysql_error());
	 
	// check for empty result
	if (mysql_num_rows($result) > 0) {
		// looping through all results
		// garajes node
		$response["garajes"] = array();
	 
		while ($row = mysql_fetch_array($result)) {
			// temp user array
			$product = array();
		$product["COD_GARAJE"] = $row["ID"];
		$product["COD_CLIENTE"] = $row["COD_CLIENTE"];
		$product["DESCRIPCION"] = $row["DESCRIPCION"];
		$product["NUM_PISOS"] = $row["NUM_PISOS"];
		$product["NUM_PARQUEOS"] = $row["NUM_PARQUEOS"];
		$product["DIRECCION"] = $row["DIRECCION"];
		$product["DIRECCION_CORD"] = $row["DIRECCION_CORD"];
		$product["DISTANCIA"] = "";
		$product["TIEMPO"] = "";
		$product["COD_PARQUEO"] = $row["ID_PARQUEO"];
		$product["COD_DESCRIPCION"] = $row["COD_DESCRIPCION"];
		$product["PISO"] = $row["PISO"];
			// push single product into final response array
			array_push($response["garajes"], $product);
		}
		
		// Arma url y parametros para consultar al web service de google
		$dir_google="http://maps.googleapis.com/maps/api/distancematrix/json";
		$pos_gps = "?origins=". $_GET['pos_gps'];
		$pos_garajes = "&destinations=" ;
		foreach($response["garajes"] as $garaje){
			$pos_garajes.=$garaje["DIRECCION_CORD"]."|";
		}
		$sensor="&sensor=false";
		$lenguaje="&language=es";
		$url_google = $dir_google.$pos_gps.$pos_garajes.$sensor.$lenguaje;
		//$url_google="http://maps.googleapis.com/maps/api/distancematrix/json?origins=-2.192589,-79.896337&destinations=-2.199215,-79.890274|-2.312215,-79.140274&sensor=false&language=es";
		$parametros=array("");// la funcion send request necesita el array de parametros vacio, los parametros van en la direccion url
		//Realiza consulta al webservice
		$JsonGoogle = SendRequest($url_google, 'POST', array(""));
		
		//Decodifico el JSON recibido de Google y coloco distancias y tiempos en array de garajes
		$arrayJsonGoogle=json_decode($JsonGoogle,true );
		$elementos=$arrayJsonGoogle["rows"][0]["elements"];
		for ($i=0; $i<count($elementos);$i++) { 
			/*echo  "Garaje $i: <br>";
			echo  "Distancia a garaje: {$elementos[$i]['distance']['text']} <br>";
			echo  "Tiempo a garaje: {$elementos[$i]['duration']['text']} <br><br>";*/
			$response["garajes"][$i]["DISTANCIA"]=$elementos[$i]['distance']['text'];
			$response["garajes"][$i]["TIEMPO"]=$elementos[$i]['duration']['text'];
		}
		//Ordeno el arreglo de menor a mayor distancia
		//echo "Respuesta JSON ANTES de ser ordenado: <br>";
		//var_dump($response);
		
		foreach ($response["garajes"] as $key => $row) {
			$DISTANCIA[$key]  = $row['DISTANCIA'];
		}
		array_multisort($DISTANCIA, SORT_ASC, $response["garajes"]);

		//echo "Respuesta JSON DESPUES de ser ordenado: <br>";
		//var_dump($response["garajes"]);
		
		// success
		$response["success"] = 1;
		// echoing JSON response
		echo json_encode($response);
	} else {
		// no garajes found
		$response["success"] = 0;
		$response["message"] = "No garajes found";
	 
		// echo no users JSON
		echo json_encode($response);
	} 

	/*!
	| @ Sends the request
	| @return string
	*/
}

function SendRequest( $url, $method = 'GET', $data = array(), $headers = array('Content-type: application/x-www-form-urlencoded') )
	{
		$context = stream_context_create(array
		(
			'http' => array(
				'method' => $method,
				'header' => $headers,
				'content' => http_build_query( $data )
			)
		));
	 
		return file_get_contents($url, false, $context);
	}

?>