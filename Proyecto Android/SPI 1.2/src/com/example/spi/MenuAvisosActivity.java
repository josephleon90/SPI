package com.example.spi;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;

public class MenuAvisosActivity extends Activity{
	private ImageView 	comidaIV, 
						ropaIV, 
						ETIV, 
						bancosIV, 
						otrosIV;
	
	private static final String CATEGORIA_COMIDA = "1";
	private static final String CATEGORIA_ROPA = "2";
	private static final String CATEGORIA_ET = "3";
	private static final String CATEGORIA_BANCOS = "4";
	private static final String CATEGORIA_OTROS = "5";
	

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.menu_aviso);
		
		this.comidaIV = (ImageView) findViewById(R.id.comidaIV);
		this.ropaIV= (ImageView) findViewById(R.id.ropaIV);
		this.bancosIV= (ImageView) findViewById(R.id.bancosIV);
		this.ETIV= (ImageView) findViewById(R.id.ETIV);
		this.otrosIV= (ImageView) findViewById(R.id.otrosIV);
		
		this.comidaIV.setOnClickListener(this.myOnlyhandler);
        this.ropaIV.setOnClickListener(this.myOnlyhandler);
        this.bancosIV.setOnClickListener(this.myOnlyhandler);
        this.ETIV.setOnClickListener(this.myOnlyhandler);
        this.otrosIV.setOnClickListener(this.myOnlyhandler);
		
	}
	
	View.OnClickListener myOnlyhandler = new View.OnClickListener() {
		  public void onClick(View v) {
			  Intent i = new Intent(getApplicationContext(), AvisosVigentesActivity.class);
			  if( comidaIV.getId() == ((ImageView)v).getId() )
			  {
				  i.putExtra("codCategoria", CATEGORIA_COMIDA);
				  startActivity(i);

		      }
		      else if( ropaIV.getId() == ((ImageView)v).getId() )
		      {
		    	  i.putExtra("codCategoria", CATEGORIA_ROPA);
				  startActivity(i);
		      }
		      else if( bancosIV.getId() == ((ImageView)v).getId() )
		      {
		    	  i.putExtra("codCategoria", CATEGORIA_BANCOS);
				  startActivity(i);
		      }
		      else if( ETIV.getId() == ((ImageView)v).getId() )
		      {
		    	  i.putExtra("codCategoria", CATEGORIA_ET);
				  startActivity(i);
		      }
		      else if( otrosIV.getId() == ((ImageView)v).getId() )
		      {
		    	  i.putExtra("codCategoria", CATEGORIA_OTROS);
				  startActivity(i);
		      }
		  }
		};
		
	
/*	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.principal, menu);
		return true;
	}*/
}
