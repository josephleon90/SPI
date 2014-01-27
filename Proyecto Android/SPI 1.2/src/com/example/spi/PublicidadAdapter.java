package com.example.spi;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

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
	 
    private HashSet<Publicidad> items = new HashSet<Publicidad>();
 
    public PublicidadAdapter(Context context, HashSet<Publicidad> items) {
        mInflater = LayoutInflater.from(context);
        System.out.println("que pasa??");
        this.items = items;
    }
 
    public int getCount() {
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
        Publicidad s = getItem(position);
        if (convertView == null) {
            convertView = mInflater.inflate(R.layout.fila_aviso, null);
            holder = new ViewHolder();
            holder.codPublicidad = (TextView) convertView.findViewById(R.id.aviso_id);
            holder.image = (ImageView) convertView.findViewById(R.id.aviso_imagen);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
        holder.codPublicidad.setText(String.valueOf(s.getCodPublicidad()));
        if (s.getImagen() != null) {
            holder.codPublicidad.setText(String.valueOf(s.getCodPublicidad()));
        	holder.image.setImageBitmap(s.getImagen());
        } else {
                // MY DEFAULT IMAGE
            holder.image.setImageResource(R.drawable.ic_launcher);
        }
        return convertView;
    }
 
    static class ViewHolder {
        TextView codPublicidad;
        ImageView image;
    }

}
