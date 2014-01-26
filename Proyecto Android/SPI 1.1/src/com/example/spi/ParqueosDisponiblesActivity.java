package com.example.spi;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONException;
import org.json.JSONObject;
import entidades.Garaje;
import entidades.Parqueo;
import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.BaseAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.ViewGroup;
import android.view.View.OnClickListener;

public class ParqueosDisponiblesActivity extends Activity {

	private String garaje_id;
	private Garaje garaje;
	private String parqueo_id;
	private static HashSet<Garaje> garajesLista;
	private String fecha_reservacion;
	private ListView list;

	// Progress Dialog
	private ProgressDialog pDialog;

	// Creating JSON Parser object
	private JSONParser jParser;

	// url to get all products list
	private static String url_all_products = "http://10.0.2.2/android_connect/reserva_parqueaderos.php";

	// JSON Node names
	private static final String TAG_SUCCESS = "success";
	private static final String TAG_COD_GARAJE = "COD_GARAJE";
	private static final String TAG_PARQUEOS = "PARQUEOS";

	@SuppressWarnings("unchecked")
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.lista_parqueos);
		list = ( ListView )findViewById( R.id.list_parqueo );
		jParser = new JSONParser();
		garajesLista = new HashSet<Garaje>();
		Intent i = getIntent();

		// getting garaje selected and parqueos list from intent
		garaje_id = i.getStringExtra(TAG_COD_GARAJE);
		garajesLista = (HashSet<Garaje>) i.getSerializableExtra(TAG_PARQUEOS);

		CustomAdapter adapter;
		ParqueosDisponiblesActivity activity = ParqueosDisponiblesActivity.this;

		/**************** Create Custom Adapter *********/
		adapter = new CustomAdapter(activity, garajesLista,
				Integer.parseInt(garaje_id));
		
		list.setAdapter(adapter);

		// on seleting single product
		// launching Edit Product Screen
		list.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> parent, View view,
					int position, long id) {
				System.out.println("Si entra al listener");
				// getting values from selected ListItem c
				parqueo_id = ((TextView) view.findViewById(R.id.parqueo_id))
						.getText().toString();
				
                // Starting new intent
                Intent in = new Intent(getApplicationContext(),
                        FechaReservacionActivity.class);
 
                // starting new activity and expecting some response back
                startActivityForResult(in, 100);
				
			}
		});
		
		

	}
	
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        // if result code 100
        if (resultCode == 100) {
        	
        	//Formato en base de fatos de la fecha: 2013-01-15 13:21:03
            String fecha = data.getStringExtra("fecha_reservacion");
            String hora = data.getStringExtra("hora_reservacion");
            System.out.println("Fecha capturada de layout: " + fecha + hora);
            
			fecha_reservacion = fecha + " " + hora;
			new CreaReservacion().execute();
			

        }
    }

	/**
	 * Background Async Task to Load all product by making HTTP Request
	 * */
	class CreaReservacion extends AsyncTask<String, String, String> {

		/**
		 * Before starting background thread Show Progress Dialog
		 * */
		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			pDialog = new ProgressDialog(ParqueosDisponiblesActivity.this);
			pDialog.setMessage("Creando reservacion. Por favor espere...");
			pDialog.setIndeterminate(false);
			pDialog.setCancelable(false);
			pDialog.show();
		}

		/**
		 * getting All products from url
		 * */
		protected String doInBackground(String... args) {
			// Building Parameters
			List<NameValuePair> params = new ArrayList<NameValuePair>();

			params.add(new BasicNameValuePair("cod_parqueo", parqueo_id));
			params.add(new BasicNameValuePair("cod_garaje", String
					.valueOf(garaje.getCodGaraje())));
			params.add(new BasicNameValuePair("cod_usuario", String.valueOf(((Global)getApplicationContext()).ID_USUARIO)));
			params.add(new BasicNameValuePair("fecha_reservacion",
					fecha_reservacion.toString()));

			// getting JSON string from URL
			JSONObject json = new JSONObject();
			System.out.println("Dirreccion a consultar: " + url_all_products);
			
			json = jParser.makeHttpRequest(url_all_products, "GET",
					params);

			// Check your log cat for JSON reponse
			Log.d("Estado reservacion: ", json.toString());

			try {
				int success = json.getInt(TAG_SUCCESS);

				if (success == 1) {
					// successfully updated
                    Intent i = getIntent();
                    // send result code 100 to notify about product update
                    setResult(100, i);
                    finish();
				} else {
					// failed to create reservation
					Toast.makeText(getApplicationContext(),
							"Error en crear la reservacion", Toast.LENGTH_LONG)
							.show();
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
			// dismiss the dialog once done
			pDialog.dismiss();

		}

	}

	/**
	 * Adaptador para mostrar la lista de parqueos en la vista
	 */
	public class CustomAdapter extends BaseAdapter implements OnClickListener {

		/*********** Declare Used Variables *********/
		private Activity activity;
		private Set<Parqueo> data;
		private LayoutInflater inflater = null;
		private ViewHolder holder;
		private TextView garaje_nombre;
		int i = 0;

		/************* CustomAdapter Constructor *****************/
		public CustomAdapter(Activity a, HashSet<Garaje> garajesLista,
				int cod_garaje) {

			/********** Take passed values **********/
			activity = a;
			Iterator<Garaje> i = garajesLista.iterator();
			
			while (i.hasNext()) {
				Garaje g = (Garaje) i.next();
				if (cod_garaje == g.getCodGaraje()) {
					garaje = g;
					data = garaje.getParqueos();
				}
			}
			/*********** Layout inflator to call external xml layout () ***********/
			inflater = (LayoutInflater) activity
					.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

		}

		/******** What is the size of Passed Arraylist Size ************/
		public int getCount() {

			if (data.size() <= 0)
				return 1;
			return data.size();
		}

		public Object getItem(int position) {
			return position;
		}

		public long getItemId(int position) {
			return position;
		}

		/******
		 * Depends upon data size called for each row , Create each ListView row
		 *****/

		public View getView(int position, View convertView, ViewGroup parent) {

			View vi = convertView;

			if (convertView == null) {

				/****** Inflate tabitem.xml file for each row ( Defined below ) *******/
				vi = inflater.inflate(R.layout.fila_parqueo, null);
				
				garaje_nombre = (TextView)findViewById(R.id.garaje_nombre);

				/****** View Holder Object to contain tabitem.xml file elements ******/
				holder = new ViewHolder();
				holder.parqueo_cod = (TextView) vi
						.findViewById(R.id.parqueo_id);
				holder.parqueo_piso = (TextView) vi
						.findViewById(R.id.parqueo_piso);
				holder.parqueo_des = (TextView) vi
						.findViewById(R.id.parqueo_des);
				
				holder.parqueo_cod.setText("");
				holder.parqueo_des.setText("");
				holder.parqueo_piso.setText("");
				
				/************ Set holder with LayoutInflater ************/
				vi.setTag(holder);
				
			} else
				holder = (ViewHolder) vi.getTag();

			if (data.size() <= 0) {
				garaje_nombre.setText("No hay parqueos disponibles");

			} else {
				/***** Get each Model object from Arraylist ********/
				Parqueo parqueo = null;
				Object[] l;
				l = garaje.getParqueos().toArray();
				parqueo = (Parqueo) l[position];

				/************ Set Model values in Holder elements ***********/

				garaje_nombre.setText(garaje.getDescripcion());
				holder.parqueo_cod.setText(String.valueOf(parqueo
						.getCodParqueo()));
				holder.parqueo_des.setText(parqueo.getCodDescripcion());
				holder.parqueo_piso.setText(String.valueOf(parqueo.getPiso()));

			}
			return vi;
		}

		@Override
		public void onClick(View v) {
			Log.v("CustomAdapter", "=====Row button clicked=====");
		}
	}

	/********* Create a holder Class to contain inflated xml file elements *********/
	private class ViewHolder {
		public TextView parqueo_cod;
		public TextView parqueo_piso;
		public TextView parqueo_des;

	}

}