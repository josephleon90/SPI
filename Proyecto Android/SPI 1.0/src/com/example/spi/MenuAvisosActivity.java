package com.example.spi;

import android.app.Activity;
import android.os.Bundle;
import android.widget.Button;

public class MenuAvisosActivity extends Activity{
	Button ingresar_but, salir_but;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.menu_aviso);
		/*
		this.ingresar_but = (Button) findViewById(R.id.ingresar_But);
		this.salir_but = (Button) findViewById(R.id.cerrar_But);
		
		this.ingresar_but.setOnClickListener(this.myOnlyhandler);
        this.salir_but.setOnClickListener(this.myOnlyhandler);
		*/
	}
	/*
	View.OnClickListener myOnlyhandler = new View.OnClickListener() {
		  public void onClick(View v) {
			  if( ingresar_but.getId() == ((Button)v).getId() )
			  {
		    	  login(v);
		      }
		      else if( salir_but.getId() == ((Button)v).getId() )
		      {
		    	  salir(v);
		      }
		  }
		};
		
		public void login(View view){
			Intent i = new Intent(this, Menu_Principal.class);
	    	//i.putExtra("id_user", id_user);
	        startActivity(i);
	    }

		public void salir(View view){
		    finish();
		}
	
	
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.principal, menu);
		return true;
	}*/
}
