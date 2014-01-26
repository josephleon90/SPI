package com.example.spi;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.TimePicker;

public class FechaReservacionActivity extends Activity{
	
	private Button reservar;
	private String fecha_reservacion;
	private String hora_reservacion;
	private DatePicker date;
	private TimePicker time;
	
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.fecha_reservacion);
		
//		fecha_reservacion_ET = (EditText)findViewById(R.id.fecha_reservacion_ET);
//		hora_reservacion_ET = (EditText)findViewById(R.id.hora_reservacion_ET);
		
		date = (DatePicker)findViewById(R.id.fechaPicker);
		time = (TimePicker)findViewById(R.id.horaPicker);
		
		reservar = (Button)findViewById(R.id.reservar_But);
		
		reservar.setOnClickListener(new View.OnClickListener() {
			 
            @Override
            public void onClick(View arg0) {

//            	fecha_reservacion = fecha_reservacion_ET.getText().toString();
//            	hora_reservacion = hora_reservacion_ET.getText().toString();
            	
            	String dia = String.valueOf(date.getDayOfMonth());
            	if(dia.length() < 2){
            		dia = "0" + dia;
            	}
            	String mes= String.valueOf(date.getMonth()+1);
            	if(mes.length() < 2){
            		mes = "0" + mes;
            	}
            	String año= String.valueOf(date.getYear());
            	fecha_reservacion = año + "/" + mes + "/" + dia;
            	System.out.println("Esta es la fecha: " + fecha_reservacion);
            	
            	String hora = String.valueOf(time.getCurrentHour());
            	if(hora.length() < 2){
            		hora = "0" + hora;
            	}
            	String minuto = String.valueOf(time.getCurrentMinute());
            	if(minuto.length() < 2){
            		minuto = "0" + minuto;
            	}
            	hora_reservacion = hora + ":" + minuto;
            	System.out.println("Esta es la hora: " + hora_reservacion);
            	
            	Intent i = getIntent();
            	i.putExtra("fecha_reservacion", fecha_reservacion);
            	i.putExtra("hora_reservacion", hora_reservacion);
            	setResult(100,i);
            	finish();
            	
            }
        });
		
	}
}
