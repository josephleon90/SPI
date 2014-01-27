package com.example.spi;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
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
import entidades.Publicidad;

public class AvisosVigentesActivity extends Activity {

	private ProgressDialog pDialog;
	private JSONParser jParser;
	private ListView list;
	private JSONArray avisos = null;
	private String categoria;
	private HashSet<Publicidad> listaAvisos;
	private TextView categoriaTV;
	private Boolean avisos_cargados = false;
	private PublicidadAdapter sta;

	// url to get all images list
	private static String url_avisos_vigentes = Global.HOST_API+Global.API_FOLDER+"/lee_publicidad.php";

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
		categoria= i.getStringExtra("codCategoria");
		// Carga avisos en Background Thread
		new CargaAvisos().execute();
		
		//Lazo para cargar imagenes en forma paralela
		do{
			if(avisos_cargados){
				sta = new PublicidadAdapter(AvisosVigentesActivity.this, listaAvisos);
		        list.setAdapter(sta);
		        for (Publicidad s : listaAvisos) {
	                // START LOADING IMAGES FOR EACH STUDENT
	                s.loadImage(sta);
	                }   
		        break;
			}
			else System.out.println("Avisos no estan cargados aun");

		}while(!avisos_cargados);


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
			
//			String urldisplay = args[0];
//	        url = urldisplay;
//	        Bitmap mIcon11 = null;
//	        try {
//	            InputStream in = new java.net.URL(urldisplay).openStream();
//	            mIcon11 = BitmapFactory.decodeStream(in);
//	        } catch (Exception e) {
//	            // Log.e("Error", e.getMessage());
//	            e.printStackTrace();
//	        }
//			this.imgBitmap = mIcon11;
			
			
			// Contruyendo parametros
			List<NameValuePair> params = new ArrayList<NameValuePair>();
			params.add(new BasicNameValuePair("tipo_loc_com", categoria));

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
						aviso.setImagenURL(c.getString(TAG_IMAGEN));
						LocalComercial lc = new LocalComercial();
						lc.setCodLocalComercial(c.getInt(TAG_COD_LOCAL_COMERCIAL));
						aviso.setLocalComercial(lc);
						
						listaAvisos.add(aviso);
						
					}

				} else {
					System.out.println("No hay avisos vigentes");
				}
				
				// Indico que los avisos fueron cargados para que lo sepa el create activity y se luego se
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

			avisos_cargados=true;	
//			// dismiss the dialog after getting all products
//			pDialog.dismiss();
//			
//			// updating UI from Background Thread
//			runOnUiThread(new Runnable() {
//				public void run() {
//					/**
//					 * Updating parsed JSON data into ListView
//					 * */
//
//					// ListView list;
//					CustomAdapter adapter;
//					AvisosVigentesActivity activity = AvisosVigentesActivity.this;
//
//					/**************** Create Custom Adapter *********/
//					adapter = new CustomAdapter(activity, listaAvisos);
//					list.setAdapter(adapter);
//
//				}
//			});

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

			public TextView cod_aviso;
			public ImageView imagen;

		}

		/******
		 * Depends upon data size called for each row , Create each ListView row
		 *****/
		public View getView(int position, View convertView, ViewGroup parent) {

			View vi = convertView;
			ViewHolder holder;

			if (convertView == null) {

				/****** Infla fila_aviso.xml para cada fila *******/
				vi = inflater.inflate(R.layout.fila_aviso, null);

				/****** View Holder Object to contain tabitem.xml file elements ******/

				holder = new ViewHolder();
				holder.imagen = (ImageView) vi.findViewById(R.id.aviso_imagen);
				holder.cod_aviso = (TextView) vi.findViewById(R.id.aviso_id);
				
				/************ Set holder with LayoutInflater ************/
				vi.setTag(holder);
			} else
				holder = (ViewHolder) vi.getTag();

			if (data.size() <= 0) {

				categoriaTV.setText("No hay avisos vigentes");
				holder.imagen.setVisibility(View.INVISIBLE);
				holder.cod_aviso.setText("-1");
			} else {
				/***** Get each Model object from Arraylist ********/
				aviso_temp = null;
				Object[] l;
				l = data.toArray();
				aviso_temp = (Publicidad) l[position];

				/************ Set Model values in Holder elements ***********/

				holder.cod_aviso.setText(String.valueOf(aviso_temp.getImagenURL()));
				
				
/*/////////////////////////////////////////////////////////////////////////////////////////

  				System.out.println("URI imagen: " + aviso_temp.getImagen());
				holder.imagen.setImageURI(Uri.parse((aviso_temp.getImagen())));
				holder.imagen.setImageBitmap(getImageBitmap(aviso_temp.getImagen()));
				new DownloadImageTask(holder.imagen).execute(aviso_temp.getImagen());
				String urlEjemplo = "http://10.0.0.5/images/logo.jpg";
				Drawable image = LoadImageFromWebOperations(aviso_temp.getImagen());
				System.out.println("Imagen: "+ image);
				holder.imagen.setImageDrawable((Drawable) image);
				DownloadImageTask dwnloadImgTask = new DownloadImageTask(((ImageView) vi.findViewWithTag(position+"i")),
                        ((ProgressBar) vi.findViewById(R.id.progressBar1)));
                dwnloadImgTask.execute(feedsImage);
                
*///////////////////////////////////////////////////////////////////////////////////////////////////
			}
			return vi;
		}
		
		private Drawable LoadImageFromWebOperations(String url)
	    {
	        try
	        {
	            InputStream is = new URL(url).openStream();
	            Drawable d = Drawable.createFromStream(is, "src name");
	            return d;
	        }
	        catch (Exception e) 
	        {
	             return null;
	        }
	    }

		@Override
		public void onClick(View v) {
			Log.v("CustomAdapter", "=====Row button clicked=====");
		}
		
		 private Bitmap getImageBitmap(String url) { 
	            Bitmap bm = null; 
	            try { 
	                URL aURL = new URL(url); 
	                URLConnection conn = aURL.openConnection(); 
	                conn.connect(); 
	                InputStream is = conn.getInputStream(); 
	                BufferedInputStream bis = new BufferedInputStream(is); 
	                bm = BitmapFactory.decodeStream(bis); 
	                bis.close(); 
	                is.close(); 
	           } catch (IOException e) { 
	               Log.e("Consiguiendo imagen", "Error consiguiendo bitmap", e); 
	           } 
	           return bm; 
	        } 
		
	}
	
	private class DownloadImageTask extends AsyncTask<String, Void, Bitmap> {
		  ImageView bmImage;

		  public DownloadImageTask(ImageView bmImage) {
		      this.bmImage = bmImage;
		  }

		  protected Bitmap doInBackground(String... urls) {
		      String urldisplay = urls[0];
		      Bitmap mIcon11 = null;
		      try {
		        InputStream in = new java.net.URL(urldisplay).openStream();
		        mIcon11 = BitmapFactory.decodeStream(in);
		      } catch (Exception e) {
		          Log.e("Error", e.getMessage());
		          e.printStackTrace();
		      }
		      return mIcon11;
		  }

		  protected void onPostExecute(Bitmap result) {
		      bmImage.setImageBitmap(result);
		  }
		}

}
