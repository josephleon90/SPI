package com.example.spi;


import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.BaseAdapter;
import android.widget.ListView;
import android.widget.TextView;
import entidades.*;

public class BuscarGarajesActivity extends Activity {
	
	// Progress Dialog
    private ProgressDialog pDialog;
 
    // Creating JSON Parser object
    private JSONParser jParser;
    private ListView list;
    HashSet<Garaje> garajesLista;
    
    // url to get all products list
    private static String url_all_products = Global.HOST_API+Global.API_FOLDER+"/lee_parqueaderos.php";
 
    // JSON Node names
    private static final String TAG_SUCCESS = "success";
    private static final String TAG_GARAJES = "garajes";
    private static final String TAG_COD_GARAJE = "COD_GARAJE";
    private static final String TAG_COD_CLIENTE = "COD_CLIENTE";
    private static final String TAG_DESCRIPCION = "DESCRIPCION";
    private static final String TAG_NUM_PISOS = "NUM_PISOS";
    private static final String TAG_NUM_PARQUEOS = "NUM_PARQUEOS";
    private static final String TAG_DISTANCIA = "DISTANCIA";
    private static final String TAG_TIEMPO = "TIEMPO";
    private static final String TAG_COD_PARQUEO = "COD_PARQUEO";
    private static final String TAG_PARQUEO_DES = "COD_DESCRIPCION";
    private static final String TAG_PISO= "PISO";
    // products JSONArray
    JSONArray garajes = null;
    
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.lista_garajes);
        list = ( ListView )findViewById( R.id.list );
        jParser = new JSONParser();
        garajesLista = new HashSet<Garaje>();
        // Loading garajes in Background Thread
        new CargaGarajes().execute();

        // on seleting single product
        // launching Edit Product Screen
        
        	list.setOnItemClickListener(new OnItemClickListener() {
        		
	            @Override
	            public void onItemClick(AdapterView<?> parent, View view,
	                    int position, long id) {
	            	
	                // getting values from selected ListItem
	                String garaje_id = ((TextView) view.findViewById(R.id.garaje_id)).getText()
	                        .toString();
	 
	                if (garaje_id != "-1" ){
		                // Starting new intent
		                Intent in = new Intent(getApplicationContext(),
		                        ParqueosDisponiblesActivity.class);
		                // sending cod_garaje to next activity
		                in.putExtra(TAG_COD_GARAJE, garaje_id);
		                in.putExtra("PARQUEOS", garajesLista);
		 
		                // starting new activity and expecting some response back
		                startActivityForResult(in, 100);
	                }
	                else
	                	System.out.println("No se consulta parqueos debido a que no hay garajes disponibles");
	            }
	        });
        }
 
    // Response from Parqueos Disponibles Activity
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        // if result code 100
        if (resultCode == 100) {
            // if result code 100 is received
            // means user edited/deleted product
            // reload this screen again
            Intent intent = getIntent();
            finish();
            startActivity(intent);
        }
    }
 
    /**
     * Background Async Task to Load all product by making HTTP Request
     * */
    class CargaGarajes extends AsyncTask<String, String, String> {
 
        /**
         * Before starting background thread Show Progress Dialog
         * */
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            pDialog = new ProgressDialog(BuscarGarajesActivity.this);
            pDialog.setMessage("Cargando Garajes. Por favor espere...");
            pDialog.setIndeterminate(false);
            pDialog.setCancelable(false);
            pDialog.show();
        }
 
        /**
         * getting All garajes from url
         * */
        protected String doInBackground(String... args) {
            // Building Parameters
            List<NameValuePair> params = new ArrayList<NameValuePair>();
            params.add(new BasicNameValuePair("pos_gps", "-2.187121,-79.881488"));
            
            JSONObject json = new JSONObject();
            // getting JSON string from URL
            json = jParser.makeHttpRequest(url_all_products, "GET", params);
 
            // Check your log cat for JSON response
            Log.d("Garajes Disponibles: ", json.toString());
 
            try {
                // Checking for SUCCESS TAG
                int success = json.getInt(TAG_SUCCESS);
 
                if (success == 1) {
                    // products found
                    // Getting Array of Garajes
                    garajes = json.getJSONArray(TAG_GARAJES);
                    garajesLista = new HashSet<Garaje> ();
                    HashSet<Parqueo> parqueoLista;
                    Garaje garaje;
                    
                    for (int i = 0; i < garajes.length(); i++) {
                    	
                    	//Obtengo un registro
                    	JSONObject c = garajes.getJSONObject(i);
                        int cod_garaje_actual= c.getInt(TAG_COD_GARAJE);
                        garaje = new Garaje();
                        //Creo una lista nueva de parqueos
                        parqueoLista = new HashSet<Parqueo>();
                        
                        //Busco los parqueos que este dentro del garaje con codigo cod_garaje_actual
                        for (int j = 0; j < garajes.length(); j++) {
                        	
                        	//Obtengo primer registro del query para buscar los parqueos del garaje
                        	JSONObject d = garajes.getJSONObject(j);
                        	int indice_parqueo = d.getInt(TAG_COD_GARAJE);
                        	if(cod_garaje_actual == indice_parqueo){
                        		Parqueo parqueo = new Parqueo();
                                parqueo.setCodDescripcion(d.getString(TAG_PARQUEO_DES));
                            	parqueo.setCodParqueo(d.getInt(TAG_COD_PARQUEO));
                            	parqueo.setPiso(d.getInt(TAG_PISO));
                                parqueoLista.add(parqueo);
                                
                                Cliente cliente = new Cliente();
                                cliente.setCodCliente(c.getInt(TAG_COD_CLIENTE));
                                
                                garaje.setCliente(cliente);
                                garaje.setCodGaraje(d.getInt(TAG_COD_GARAJE));
                                garaje.setDescripcion(d.getString(TAG_DESCRIPCION));
                                garaje.setNumParqueos(d.getInt(TAG_NUM_PARQUEOS));
                                garaje.setNumPisos(d.getInt(TAG_NUM_PISOS));
                                garaje.setDistancia(d.getString(TAG_DISTANCIA));
                                garaje.setTiempo(d.getString(TAG_TIEMPO));
                            }
                        }
                        
                        garaje.setParqueos(parqueoLista);
                    	garajesLista.add(garaje);
                    	//System.out.println("Garaje agregado a la lista: \n" + garaje.toString());
                        
                    }
                    
//                    System.out.println("Muestro lista de garajes disponible hallados en el arrayList");
//                    System.out.println(garajesLista.toString());
                } else {
                	garajesLista = new HashSet<Garaje> ();
                	System.out.println("No hay garajes");
                }
            } catch (JSONException e) {
                e.printStackTrace();
            }
 
            return null;
        }
 
        /**
         * After completing background task Dismiss the progress dialog
         * **/
        protected void onPostExecute(String file_url) {
            // dismiss the dialog after getting all products
            pDialog.dismiss();
            // updating UI from Background Thread
            runOnUiThread(new Runnable() {
                public void run() {
                    /**
                     * Updating parsed JSON data into ListView
                     * */
                	
                	 //ListView list;
                     CustomAdapter adapter;
                     BuscarGarajesActivity activity = BuscarGarajesActivity.this;
                     
                    /**************** Create Custom Adapter *********/
                    adapter = new CustomAdapter( activity, garajesLista);
                    list.setAdapter( adapter );
                    
                }
            });
 
        }
 
    }
    
    /********* Adapter class extends with BaseAdapter and implements with OnClickListener ************/
    public class CustomAdapter extends BaseAdapter   implements OnClickListener {
              
             /*********** Declare Used Variables *********/
             private Activity activity;
             private HashSet<Garaje> data;
             private LayoutInflater inflater=null;
             Garaje garaje_temp=null;
             int i=0;
              
             /*************  CustomAdapter Constructor *****************/
             public CustomAdapter(Activity a, HashSet<Garaje> garajesLista) {
                  
                    /********** Take passed values **********/
                     activity = a;
                     data = garajesLista;
                  
                     /***********  Layout inflator to call external xml layout () ***********/
                      inflater = ( LayoutInflater )activity.
                                                  getSystemService(Context.LAYOUT_INFLATER_SERVICE);
                  
             }
          
             /******** What is the size of Passed Arraylist Size ************/
             public int getCount() {
                  
                 if(data.size()<=0)
                     return 1;
                 return data.size();
             }
          
             public Object getItem(int position) {
                 return position;
             }
          
             public long getItemId(int position) {
                 return position;
             }
              
             /********* Create a holder Class to contain inflated xml file elements *********/
             private class ViewHolder{
                  
                 public TextView garaje_nombre;
                 public TextView garaje_cod;
                 public TextView garaje_distancia;
                 public TextView garaje_tiempo;
          
             }
          
             /****** Depends upon data size called for each row , Create each ListView row *****/
             public View getView(int position, View convertView, ViewGroup parent) {
                  
                 View vi = convertView;
                 ViewHolder holder;
                  
                 if(convertView==null){
                      
                     /****** Inflate tabitem.xml file for each row ( Defined below ) *******/
                     vi = inflater.inflate(R.layout.fila_garaje, null);
                      
                     /****** View Holder Object to contain tabitem.xml file elements ******/
     
                     holder = new ViewHolder();
                     holder.garaje_nombre = (TextView) vi.findViewById(R.id.garaje_nombre);
                     holder.garaje_cod = (TextView)vi.findViewById(R.id.garaje_id);
                     holder.garaje_distancia = (TextView)vi.findViewById(R.id.garaje_distancia);
                     holder.garaje_tiempo = (TextView)vi.findViewById(R.id.garaje_tiempo);
                     
                     holder.garaje_nombre.setText("");
                     holder.garaje_cod.setText("");
                     holder.garaje_distancia.setText("");
                     holder.garaje_tiempo.setText("");
                     
                    /************  Set holder with LayoutInflater ************/
                     vi.setTag( holder );
                 }
                 else 
                     holder=(ViewHolder)vi.getTag();
                  
                 if(data.size()<=0)
                 {
                	 TextView labelDistancia = (TextView)vi.findViewById(R.id.textView1);
                	 labelDistancia.setVisibility(View.INVISIBLE);
                	 TextView labelTiempo = (TextView)vi.findViewById(R.id.textView2);
                	 labelTiempo.setVisibility(View.INVISIBLE);
                	 holder.garaje_distancia.setVisibility(View.INVISIBLE);
                	 holder.garaje_tiempo.setVisibility(View.INVISIBLE);
                	 holder.garaje_nombre.setText("No hay garajes disponibles");
                	//Indico que no hay garajes disponible para que lo sepa el listener al momento de construir
                	 holder.garaje_cod.setText("-1"); 
                 }
                 else
                 {
                     /***** Get each Model object from Arraylist ********/
                     garaje_temp = null;
                     Object[] l;
                     l =  data.toArray();
                     garaje_temp = (Garaje)l[position];
                      
                     /************  Set Model values in Holder elements ***********/
     
                      holder.garaje_nombre.setText(garaje_temp.getDescripcion());
                      holder.garaje_cod.setText(String.valueOf(garaje_temp.getCodGaraje()));
                      holder.garaje_distancia.setText(garaje_temp.getDistancia());
                      holder.garaje_tiempo.setText(garaje_temp.getTiempo());
                      
                      /******** Set Item Click Listner for LayoutInflater for each row *******/
     
                      //vi.setOnClickListener(new OnItemClickListener( position ));
                 }
                 return vi;
             }
              
             @Override
             public void onClick(View v) {
                     Log.v("CustomAdapter", "=====Row button clicked=====");
             } 
         }
	
}
