package com.example.spi;

import java.util.HashSet;
import entidades.Publicidad;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

public class PublicidadAdapter extends BaseAdapter{
	
	private LayoutInflater mInflater;
	private String tipoAviso;
	
    private HashSet<Publicidad> items = new HashSet<Publicidad>();
 
    public PublicidadAdapter(Context context, HashSet<Publicidad> items) {

    	mInflater = LayoutInflater.from(context);
        this.items = items;
    }
 
    public int getCount() {
        if(items.size()<=0)
            return 1;
        return items.size();
    }
 
    public Publicidad getItem(int position) {
		Object[] l;
		l = items.toArray();
		return (Publicidad) l[position];
    }
 
    public long getItemId(int position) {
        return position;
    }
 
    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder holder;
        Publicidad s;
        
        if (convertView == null) {
            convertView = mInflater.inflate(R.layout.fila_aviso, null);
            holder = new ViewHolder();
            holder.codPublicidad = (TextView) convertView.findViewById(R.id.aviso_id);
            holder.image = (ImageView) convertView.findViewById(R.id.aviso_imagen);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
        
        if (items.size()>0){
        	s = getItem(position);
            holder.codPublicidad.setText(String.valueOf(s.getCodPublicidad()));
            // Si tengo un codigo de aviso valido y una imagen muestro el aviso en el layout
            if (s.getImagen() != null && s.getCodPublicidad() != 0) {
                holder.codPublicidad.setText(String.valueOf(s.getCodPublicidad()));
            	holder.image.setImageBitmap(s.getImagen());
            } else if(s.getImagen() == null && s.getCodPublicidad() != 0){
                    // Si no tengo imagen pongo una default
                holder.image.setImageResource(R.drawable.ic_launcher);
            }
        } else {
        	
        	holder.codPublicidad.setText("-1");
        	holder.image.setVisibility(View.INVISIBLE);
        }
        return convertView;
    }
 
    static class ViewHolder {
        TextView codPublicidad;
        ImageView image;
    }

}
