<?php
 
/*
 * Following code will list a image
 */
 
 //URL para prueba
 //http://localhost:82/android_connect/lee_img_publicidad.php?cod_imagen=1
 
// array for JSON response
$response = array();

// include db connect class
require_once __DIR__ . '/db_connect.php';
 
// connecting to db
$db = new DB_CONNECT();
 
if (isset($_GET["cod_imagen"])) {
	$cod_imagen=$_GET["cod_imagen"];
	 
	// get all ads from ads table
	$result = mysql_query("	SELECT IMAGEN FROM PUBLICIDAD WHERE COD_PUBLICIDAD =$cod_imagen") or die(mysql_error());
	 
	// check for empty result
	if (mysql_num_rows($result) > 0) {
		// looping through all results
		// ads node
		$response["ads"] = array();
	 
		while ($row = mysql_fetch_array($result)) {
			// temp user array
			$ad = array();
			$ad["imagen"] = $row["IMAGEN"];
			// push single ad into final response array
			array_push($response["ads"], $ad);
		}
		// success
		$response["success"] = 1;
		
		header("content-type: image/jpeg");
		for ($i=0; $i<count($response["ads"]); $i++){
			echo "{$response['ads'][$i]['imagen']}>";
		}
		
		//Segundo metodo para imprimir imagen
		/*//////////////////////////////////////////////
		$db_img = $response['ads'][1]['imagen'];
		//$db_img = base64_decode($db_img);
		$img = imagecreatefromstring($db_img);
		$type="jpeg";
		
		if ($img !== false) {	
			switch ($type) {
				case "jpeg":
				header("Content-Type: image/jpeg");
				imagejpeg($img);
				break;
				
				case "gif":
				header("Content-Type: image/gif");
				imagegif($img);
				break;
				
				case "png":
				header("Content-Type: image/png");
				imagepng($img);
				break;
				
				
			}
		}
		imagedestroy($db_img);
		////////////////////////////////////////////////////*/
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