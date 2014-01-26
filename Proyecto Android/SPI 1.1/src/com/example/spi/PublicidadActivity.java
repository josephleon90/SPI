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
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import entidades.*;

public class PublicidadActivity extends Activity {

	private ProgressDialog pDialog;
	private JSONParser jParser;
	private ListView list;
	private JSONArray avisos = null;
	private String categoria;
	private HashSet<Publicidad> listaAvisos;

	// url to get all images list
	private static String url_avisos_vigentes = "http://10.0.2.2/android_connect/lee_publicidad.php";

	// JSON Node names
	private static final String TAG_SUCCESS = "success";
	private static final String TAG_AVISOS = "ads";
	private static final String TAG_COD_AVISO = "COD_PUBLICIDAD";
	private static final String TAG_COD_LOCAL_COMERCIAL = "COD_LOCAL_COMERCIAL";
	private static final String TAG_COD_USUARIO = "COD_USUARIO";
	private static final String TAG_IMAGEN = "IMAGEN";
	private static final String TAG_FECHA_REGISTRO = "FECHA_REGISTRO";
	private static final String TAG_FECHA_VENCIMIENTO = "FECHA_VENCIMIENTO";

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.lista_avisos);
		list = (ListView) findViewById(R.id.list_avisos);
		jParser = new JSONParser();

		// Carga avisos en Background Thread
		new CargaAvisos().execute();

	}

	/**
	 * Background Async Task para cargar todos los avisos vigentes haciendo HTTP
	 * Request
	 * */
	class CargaAvisos extends AsyncTask<String, String, String> {

		/**
		 * Before starting background thread Show Progress Dialog
		 * */
		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			pDialog = new ProgressDialog(PublicidadActivity.this);
			pDialog.setMessage("Cargando Avisos. Por favor espere...");
			pDialog.setIndeterminate(false);
			pDialog.setCancelable(false);
			pDialog.show();
		}

		/**
		 * Consultando todos los avisos de la url
		 * */
		protected String doInBackground(String... args) {
			// Contruyendo parametros
			List<NameValuePair> params = new ArrayList<NameValuePair>();
			params.add(new BasicNameValuePair("categoria", categoria));

			JSONObject json = new JSONObject();
			// Haciendo el Request
			json = jParser.makeHttpRequest(url_avisos_vigentes, "GET", params);

			// Check your log cat for JSON response
			Log.d("Avisos Vigentes: ", json.toString());

			try {
				// Checking for SUCCESS TAG
				int success = json.getInt(TAG_SUCCESS);

				if (success == 1) {
					listaAvisos = new HashSet<Publicidad>();
					avisos = json.getJSONArray(TAG_AVISOS);
					Publicidad aviso;

					for (int j = 0; j < avisos.length(); j++) {

						aviso = new Publicidad();
						// Obtengo un registro
						JSONObject c = avisos.getJSONObject(j);
						aviso.setCodPublicidad(c.getInt(TAG_COD_AVISO));
						aviso.setFecha_registro(c.getString(TAG_FECHA_REGISTRO));
						aviso.setFecha_vencimiento(c.getString(TAG_FECHA_VENCIMIENTO));
						aviso.setImagen(c.getString(TAG_IMAGEN));
						LocalComercial lc = new LocalComercial();
						lc.setCodLocalComercial(c.getInt(TAG_COD_LOCAL_COMERCIAL));
						aviso.setLocalComercial(lc);
						
						listaAvisos.add(aviso);
						
					}

				} else {
					System.out.println("No hay avisos vigentes");
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

					// ListView list;
					CustomAdapter adapter;
					PublicidadActivity activity = PublicidadActivity.this;

					/**************** Create Custom Adapter *********/
					adapter = new CustomAdapter(activity, listaAvisos);
					list.setAdapter(adapter);

				}
			});

		}

	}

	/*********
	 * Adapter class extends with BaseAdapter and implements with
	 * OnClickListener
	 ************/
	public class CustomAdapter extends BaseAdapter implements OnClickListener {

		/*********** Declare Used Variables *********/
		private Activity activity;
		private HashSet<Publicidad> data;
		private LayoutInflater inflater = null;
		Publicidad aviso_temp = null;
		int i = 0;

		/************* CustomAdapter Constructor *****************/
		public CustomAdapter(Activity a, HashSet<Publicidad> listaAvisos) {

			/********** Take passed values **********/
			activity = a;
			data = listaAvisos;

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

		/********* Create a holder Class to contain inflated xml file elements *********/
		private class ViewHolder {

			public ImageView imagen;

		}

		/******
		 * Depends upon data size called for each row , Create each ListView row
		 *****/
		public View getView(int position, View convertView, ViewGroup parent) {

			View vi = convertView;
			ViewHolder holder;

			if (convertView == null) {

				/****** Inflate tabitem.xml file for each row ( Defined below ) *******/
				vi = inflater.inflate(R.layout.fila_garaje, null);

				/****** View Holder Object to contain tabitem.xml file elements ******/

				holder = new ViewHolder();
				holder.imagen = (TextView) vi
						.findViewById(R.id.garaje_nombre);
				holder.garaje_cod = (TextView) vi.findViewById(R.id.garaje_id);
				holder.garaje_distancia = (TextView) vi
						.findViewById(R.id.garaje_distancia);

				holder.imagen.setText("");
				holder.garaje_cod.setText("");
				holder.garaje_distancia.setText("");

				/************ Set holder with LayoutInflater ************/
				vi.setTag(holder);
			} else
				holder = (ViewHolder) vi.getTag();

			if (data.size() <= 0) {
				TextView labelDistancia = (TextView) vi
						.findViewById(R.id.textView1);
				labelDistancia.setVisibility(View.INVISIBLE);
				holder.garaje_distancia.setVisibility(View.INVISIBLE);
				holder.imagen.setText("No hay garajes disponibles");
				// Indico que no hay garajes disponible para que lo sepa el
				// listener al momento de construir
				holder.garaje_cod.setText("-1");
			} else {
				/***** Get each Model object from Arraylist ********/
				aviso_temp = null;
				Object[] l;
				l = data.toArray();
				aviso_temp = (Garaje) l[position];

				/************ Set Model values in Holder elements ***********/

				holder.imagen.setText(aviso_temp.getDescripcion());
				holder.garaje_cod.setText(String.valueOf(aviso_temp
						.getCodGaraje()));
				holder.garaje_distancia.setText(aviso_temp.getDistancia());

				/******** Set Item Click Listner for LayoutInflater for each row *******/

				// vi.setOnClickListener(new OnItemClickListener( position ));
			}
			return vi;
		}

		@Override
		public void onClick(View v) {
			Log.v("CustomAdapter", "=====Row button clicked=====");
		}
	}

}
