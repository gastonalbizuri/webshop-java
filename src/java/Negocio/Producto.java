/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Negocio;

import java.sql.Blob;



/**
 *
 * @author Usuario
 */
public class Producto {
    int id_producto;
    String nombre;
    String descripcion;
    float precio;
    Blob foto;
    String categoria;
    
    public Producto(int id, String nom, String desc, float pre, Blob imag, String cat){
        this.id_producto = id;
        this.nombre = nom;
        this.descripcion = desc;
        this.precio = pre;
        this.foto = imag;
        this.categoria = cat;
    }

    public Producto(){
        
    }
    
    public String base64Image;
 
 
    public String getBase64Image() {
        return base64Image;
    }
 
    public void setBase64Image(String base64Image) {
        this.base64Image = base64Image;
    }
    
    public int getID(){
        return id_producto;
    }
    
    public void setID(int id){
        this.id_producto = id;
    }
    
    public String getNombre(){
        return nombre;
    }
    
    public void setNombre(String nom){
        this.nombre = nom;
    }
    
    public String getDescripcion(){
        return descripcion;
    }
    
    public void setDescripcion(String desc){
        this.descripcion = desc;
    }
    
    public float getPrecio(){
        return precio;
    }
    
    public void setPrecio(float pre){
        this.precio = pre;
    }
    
    public Blob getFoto(){
        return foto;
    }
    
    public void setFoto(Blob imag){
        this.foto = imag;
    }
    
    public String getCategoria(){
        return categoria;
    }
    
    public void setCategoria(String cat){
        this.categoria = cat;
    }
    
}
