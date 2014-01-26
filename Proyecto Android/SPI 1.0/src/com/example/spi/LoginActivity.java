package com.example.spi;

import java.util.ArrayList;
import java.util.List;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class LoginActivity extends Activity {
	
	EditText usuario_ET, contraseña_ET;
    Button ingresar_but, salir_but;
    Toast toast1;
    
    // Progress Dialog
    private ProgressDialog pDialog;
    AlertDialog alertDialog;
	
 
    // JSON parser class
    JSONParser jsonParser = new JSONParser();
 
    // single product url
    private static final String url_user_detials = Global.HOST_DIR+Global.API_FOLDER+"/login.php";
 
    // JSON Node names
    private static final String TAG_SUCCESS = "success";
    private static final String TAG_USUARIO = "USUARIO";
    private static final String TAG_USUARIO_ID = "COD_USUARIO";
    private static final String TAG_USUARIO_NOMBRE = "NOMBRE";
    private static final String TAG_USUARIO_APELLIDO = "APELLIDO";
    private static final String TAG_USUARIO_PLACA = "PLACA";

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.login);
		this.usuario_ET = (EditText)findViewById(R.id.usuario_ET);
		this.contraseña_ET = (EditText)findViewById(R.id.clave_ET);
		
		this.ingresar_but = (Button) findViewById(R.id.ingresar_But);
		this.salir_but = (Button) findViewById(R.id.cerrar_But);
		
		this.ingresar_but.setOnClickListener(this.myOnlyhandler);
        this.salir_but.setOnClickListener(this.myOnlyhandler);
	
	}
	
	View.OnClickListener myOnlyhandler = new View.OnClickListener() {
		  public void onClick(View v) {
			  if( ingresar_but.getId() == ((Button)v).getId() )
			  {
				  new ValidaLogin().execute();
		      }
		      else if( salir_but.getId() == ((Button)v).getId() )
		      {
		    	  salir(v);
		      }
		  }
		};
		
		class ValidaLogin extends AsyncTask<String, String, String> {
			 
	        /**
	         * Before starting background thread Show Progress Dialog
	         * */
	        @Override
	        protected void onPreExecute() {
	            super.onPreExecute();
	            pDialog = new ProgressDialog(LoginActivity.this);
	            pDialog.setMessage("Comprobando usuario y contraseña. Por favor espere...");
	            pDialog.setIndeterminate(false);
	            pDialog.setCancelable(false);
	            pDialog.show();
	        }
	 
	        /**
	         * Getting user details in background thread
	         * */
	        protected String doInBackground(String... args) {
	        	
                // Building Parameters
            	String usuario = usuario_ET.getText().toString();
            	String contraseña = contraseña_ET.getText().toString();
                
            	try {
            	if(usuario != "" && contraseña != ""){
            		List<NameValuePair> params = new ArrayList<NameValuePair>();
                    params.add(new BasicNameValuePair("usuario_login", usuario));
                    params.add(new BasicNameValuePair("password_login", contraseña));
                    
                    // getting user details by making HTTP request
                    // Note that user details url will use GET request
                    JSONObject json = jsonParser.makeHttpRequest(
                            url_user_detials, "GET", params);
 
                        // check your log for json response
                    Log.d("Single User Details", json.toString());
 
                   
                    // json success tag
                    int success = json.getInt(TAG_SUCCESS);
                    if (success == 1) {
                        // successfully received product details
                        JSONArray productObj = json
                                .getJSONArray(TAG_USUARIO); // JSON Array
 
                            // get first product object from JSON Array
                            JSONObject usuario_JSON = productObj.getJSONObject(0);
 
                            // product with this pid found
                        // Guardo la informacion del usuario en una variable global a toda la aplicacion
                        ((Global)getApplicationContext()).ID_USUARIO = usuario_JSON.getInt(TAG_USUARIO_ID);
                        ((Global)getApplicationContext()).USUARIO_NOMBRE = usuario_JSON.getString(TAG_USUARIO_NOMBRE);
                        ((Global)getApplicationContext()).USUARIO_APELLIDO = usuario_JSON.getString(TAG_USUARIO_APELLIDO);
                        ((Global)getApplicationContext()).USUARIO_PLACA = usuario_JSON.getString(TAG_USUARIO_PLACA);
                        
                        //Inicio la otra actividad dado que encontro la informacion del usuario
                        Intent i = new Intent(getApplicationContext(), MenuPrincipalActivity.class);
                        startActivity(i);
     
                        // closing this screen
                        finish();
                        
                    }else{
                        // user with information not found
                    	/*alertDialog = new AlertDialog.Builder(LoginActivity.this).create();
                		alertDialog.setTitle("Error");
                		alertDialog.setMessage("Usuario o contraseña incorrectos");
                		alertDialog.show();*/
                    	System.out.println("Usuario o contraseña incorrectos");
                    	//No funciona el toast
                    	//Toast.makeText(getApplicationContext(),"Usuario o contraseña incorrectos", Toast.LENGTH_LONG).show();
                		
                    }
                    
            	} if(usuario == "" && contraseña == "") {
            		/*AlertDialog alertDialog;
            		alertDialog = new AlertDialog.Builder(LoginActivity.this).create();
            		alertDialog.setTitle("Alerta");
            		alertDialog.setMessage("Ha ingresado con un usuario general");
            		alertDialog.show();*/
            		
            		
            		Intent i = new Intent(getApplicationContext(), MenuPrincipalActivity.class);
            		startActivity(i);
            		
            		System.out.println("Ha ingresado con un usuario general");
            		Toast.makeText(getApplicationContext(),"Ha ingresado con un usuario general", Toast.LENGTH_LONG).show();
            		
            		finish();
            	}
            	}catch(JSONException e) {
                    e.printStackTrace();    
            	}
	            return null;
	        }
	 
	        /**
	         * After completing background task Dismiss the progress dialog
	         * **/
	        protected void onPostExecute(String file_url) {
	            // dismiss the dialog once got all details
	        	usuario_ET.setText("");
	        	contraseña_ET.setText("");
	        	pDialog.dismiss();
	    		
	        }
	    }

		public void salir(View view){
		    finish();
		}
	
	
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.principal, menu);
		return true;
	}

}
