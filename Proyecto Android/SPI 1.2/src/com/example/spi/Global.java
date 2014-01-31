package com.example.spi;

import android.app.Application;

public  class  Global extends Application {
	//Inicialmente cargado con datos del usuario generico
	public int ID_USUARIO = 2;
	public String USUARIO_NOMBRE = "GENERICO";
	public String USUARIO_APELLIDO = "";
	public String USUARIO_PLACA = "";
	//public static final String HOST_API = "http://localhost";
	//public static final String HOST_API = "http://10.0.2.2";
	public static final String HOST_API = "http://192.168.0.3:80";
	public static final String API_FOLDER = "/android_connect";
	public static final String IMAGE_FOLDER = "/android_avisos";
} 
