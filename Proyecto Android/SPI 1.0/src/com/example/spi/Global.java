package com.example.spi;

import android.app.Application;

public  class  Global extends Application {
	//Inicialmente cargado con datos del usuario generico
	public int ID_USUARIO = 2;
	public String USUARIO_NOMBRE = "GENERICO";
	public String USUARIO_APELLIDO = "";
	public String USUARIO_PLACA = "";
	public static final String HOST_DIR = "http://192.168.1.107";
	public static final String API_FOLDER = "/android_connect";
} 
