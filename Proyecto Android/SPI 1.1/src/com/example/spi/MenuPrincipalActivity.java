package com.example.spi;

import android.os.Bundle;
import android.view.View;
import android.app.Activity;
import android.content.Intent;
import android.widget.*;


public class MenuPrincipalActivity extends Activity{
	
	ImageView buscar_but, avisos_but, atras_but;
	
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.menu_principal);
		
		this.buscar_but = (ImageView) findViewById(R.id.buscar_IV);
		this.avisos_but = (ImageView) findViewById(R.id.avisos_IV);
		
		this.buscar_but.setOnClickListener(this.myOnlyhandler);
        this.avisos_but.setOnClickListener(this.myOnlyhandler);
	
	}
	
	View.OnClickListener myOnlyhandler = new View.OnClickListener() {
		  public void onClick(View v) {
			  if( buscar_but.getId() == ((ImageView)v).getId() )
			  {
		    	  buscar(v);
		      }
		      else if( avisos_but.getId() == ((ImageView)v).getId() )
		      {
		    	  avisos(v);
		      }
		  }
		};
		
		public void buscar(View view){
			Intent i = new Intent(this, BuscarGarajesActivity.class);
	    	//i.putExtra("id_user", id_user);
	        startActivity(i);
	    }
		
		public void avisos(View view){
			Intent i = new Intent(this, MenuAvisosActivity.class);
	    	//i.putExtra("id_user", id_user);
	        startActivity(i);
	    }

}
