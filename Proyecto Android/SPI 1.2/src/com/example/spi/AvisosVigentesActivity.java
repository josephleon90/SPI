package com.example.spi;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.HashMap;
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
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.Drawable;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import entidades.LocalComercial;
import entidades.LocalComercialTipo;
import entidades.Publicidad;

public class AvisosVigentesActivity extends Activity {

	private ProgressDialog pDialog;
	private JSONParser jParser;
	private ListView list;
	private JSONArray avisos = null;
	private String cod_categoria;
	private String categoria="";
	private HashSet<Publicidad> listaAvisos;
	private HashMap<String,LocalComercialTipo> listaTipoLocCom;
	private TextView categoriaTV;
	private PublicidadAdapter sta;

	// url to get all images list
	private static String url_avisos_vigentes = Global.HOST_API
			+ Global.API_FOLDER + "/lee_publicidad.php";

	// JSON Node names
	private static final String TAG_SUCCESS = "success";
	private static final String TAG_AVISOS = "ads";
	private static final String TAG_COD_AVISO = "COD_PUBLICIDAD";
	private static final String TAG_COD_LOCAL_COMERCIAL = "COD_LOCAL_COMERCIAL";
	private static final String TAG_IMAGEN = "IMAGEN";
	private static final String TAG_FECHA_REGISTRO = "FECHA_REGISTRO";
	private static final String TAG_FECHA_VENCIMIENTO = "FECHA_VENCIMIENTO";

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.lista_avisos);
		list = (ListView) findViewById(R.id.list_avisos);
		categoriaTV = (TextView) findViewById(R.id.tipo_aviso);
		jParser = new JSONParser();

		Intent i = getIntent();
		cod_categoria = i.getStringExtra("codCategoria");
		cargaTipoLocCom();
		System.out.println("lista de tipo locales "+listaTipoLocCom.toString());
		System.out.println("Tamaño de tipo loc com "+listaTipoLocCom.size());
		System.out.println("COd de la categoria: "+cod_categoria);
		
		LocalComercialTipo temp = (LocalComercialTipo)listaTipoLocCom.get(cod_categoria);
		System.out.println("LocalComericalTIpo "+temp.toString());
		categoria=temp.getDescripcion();
		categoriaTV.setText("Avisos de " + categoria);
		// Carga avisos en Background Thread
		new CargaAvisos().execute();

	}
	
	public void cargaTipoLocCom (){
		listaTipoLocCom =  new HashMap<String,LocalComercialTipo> ();
		LocalComercialTipo comida = new LocalComercialTipo(1,"Comidas");
		LocalComercialTipo ropa = new LocalComercialTipo(2,"Ropas");
		LocalComercialTipo et = new LocalComercialTipo(3,"ET");
		LocalComercialTipo banco= new LocalComercialTipo(4,"Bancos");
		LocalComercialTipo otro = new LocalComercialTipo(5,"Otros");
		
		listaTipoLocCom.put("1",comida);
		listaTipoLocCom.put("2",ropa);
		listaTipoLocCom.put("3",et);
		listaTipoLocCom.put("4",banco);
		listaTipoLocCom.put("5",otro);
				
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
			pDialog = new ProgressDialog(AvisosVigentesActivity.this);
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
			params.add(new BasicNameValuePair("tipo_loc_com", cod_categoria));
			
			listaAvisos = new HashSet<Publicidad>();
			JSONObject json = new JSONObject();
			// Haciendo el Request
			json = jParser.makeHttpRequest(url_avisos_vigentes, "GET", params);
			System.out.println("imprimo publoicidad +" + json.toString());
			System.out.println("imprimo la url de consulta: "+ url_avisos_vigentes);
			System.out.println("Imprimo el parametro "+categoria);
			// Check your log cat for JSON response
			Log.d("Avisos Vigentes: ", json.toString());

			try {
				// Checking for SUCCESS TAG
				int success = json.getInt(TAG_SUCCESS);

				if (success == 1) {
					avisos = json.getJSONArray(TAG_AVISOS);
					Publicidad aviso = new Publicidad();
					
					for (int j = 0; j < avisos.length(); j++) {
						aviso = new Publicidad();
						// Obtengo un registro
						JSONObject c = avisos.getJSONObject(j);
						aviso.setCodPublicidad(c.getInt(TAG_COD_AVISO));
						aviso.setFecha_registro(c.getString(TAG_FECHA_REGISTRO));
						aviso.setFecha_vencimiento(c
								.getString(TAG_FECHA_VENCIMIENTO));
						aviso.setImagenURL(c.getString(TAG_IMAGEN));
						LocalComercial lc = new LocalComercial();
						lc.setCodLocalComercial(c
								.getInt(TAG_COD_LOCAL_COMERCIAL));
						aviso.setLocalComercial(lc);

						listaAvisos.add(aviso);

					}

				} else {
					System.out.println("No hay avisos vigentes");
				}

				// Indico que los avisos fueron cargados para que lo sepa el
				// create activity y se luego se
				// se carguen las imagenes con el url de los avisos

			} catch (JSONException e) {
				e.printStackTrace();
			}

			return null;
		}

		/**
		 * After completing background task Dismiss the progress dialog
		 * **/
		protected void onPostExecute(String file_url) {
			sta = new PublicidadAdapter(AvisosVigentesActivity.this,
					listaAvisos);
			list.setAdapter(sta);
			if(listaAvisos.size()>0){
				int i=0;
				for (Publicidad s : listaAvisos) {
					s.loadImage(sta,i,listaAvisos.size(),pDialog);
					i++;
				}
			}
			else{
				categoriaTV.setText("No existen avisos vigentes");
				pDialog.dismiss();
			}
		}
	}
}
