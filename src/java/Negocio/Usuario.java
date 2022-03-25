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
public class Usuario {
    String usuario;
    String pass;
    String tipo_usuario;
    String nombre;
    String apellido;
    String telefono;
    String email;
    String direccion;
    Blob foto_perfil;
    
    public Usuario(String usu, String con, String tipoUsu, String nom, String ape, String tel, String mail, String dir, Blob foto) {
        this.usuario = usu;
        this.pass = con;
        this.tipo_usuario = tipoUsu;
        this.nombre = nom;
        this.apellido = ape;
        this.telefono = tel;
        this.email = mail;
        this.direccion = dir;
        this.foto_perfil = foto;
    }
    
    public Usuario (){
    }
    
    public String base64Image;
 
 
    public String getBase64Image() {
        return base64Image;
    }
 
    public void setBase64Image(String base64Image) {
        this.base64Image = base64Image;
    }
    
    public String getUsuario(){
        return usuario;
    }
    
    public void setUsuario(String usu){
        this.usuario = usu;
    }
    
    public String getPassword(){
        return pass;
    }
    
    public void setPassword(String con){
        this.pass = con;
    }
    
    public String getTipoUsuario(){
        return tipo_usuario;
    }
    
    public void setTipoUsuario(String tipoUsu){
        this.tipo_usuario = tipoUsu;
    }
    
    public String getNombre(){
        return nombre;
    }
    
    public void setNombre(String nom){
        this.nombre = nom;
    }
    
    public String getApellido(){
        return apellido;
    }
    
    public void setApellido(String ape){
        this.apellido = ape;
    }
    
    public String getTelefono(){
        return telefono;
    }
    
    public void setTelefono(String tel){
        this.telefono = tel;
    }
    
    public String getMail(){
        return email;
    }
    
    public void setMail(String mail){
        this.email = mail;
    }
    
    public String getDireccion(){
        return direccion;
    }
    
    public void setDireccion(String dir){
        this.direccion = dir;
    }
    
    public Blob getFoto(){
        return foto_perfil;
    }
    
    public void setFoto(Blob foto){
        this.foto_perfil = foto;
    }
}
