/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Datos;

import Negocio.Usuario;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.Base64;

/**
 *
 * @author Usuario
 */
public class ConsultaUsuario extends Conexion{
    
    private String error= null;
    
    public String getError(){
        return error;
    }
    
    public void setError(String error){
        this.error = error;
    }
   
    public Usuario login(String usuario, String pass){
        PreparedStatement pst = null;
        ResultSet rs = null;
        Usuario usuarioActual = new Usuario();
        
         try {
            String query = "SELECT * FROM usuario WHERE usuario = ? AND pass = ?";
            Connection conexion = getConexion();
            pst = conexion.prepareStatement(query);
            pst.setString(1, usuario);
            pst.setString(2, pass);
            rs = pst.executeQuery();
            
            if (rs.next()){
                String usu = rs.getString("usuario");
                String cont = rs.getString("pass");
                String nom = rs.getString("nombre");
                String ape = rs.getString("apellido");
                String tipoUsu = rs.getString("tipo_usuario");
                String tel = rs.getString("telefono");
                String email = rs.getString("email");
                String dir = rs.getString("direccion");
                Blob blob = rs.getBlob("foto_perfil");
 
                InputStream inputStream = blob.getBinaryStream();
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                byte[] buffer = new byte[4096];
                int bytesRead = -1;
 
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
 
                byte[] imageBytes = outputStream.toByteArray();
 
                String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                          
                inputStream.close();
                outputStream.close();
                
                usuarioActual.setUsuario(usu);
                usuarioActual.setPassword(cont);
                usuarioActual.setNombre(nom);
                usuarioActual.setApellido(ape);
                usuarioActual.setTipoUsuario(tipoUsu);
                usuarioActual.setTelefono(tel);
                usuarioActual.setMail(email);
                usuarioActual.setDireccion(dir);
                usuarioActual.setBase64Image(base64Image);
                
                return usuarioActual;
            }
        } catch (Exception e) {
            error = "Error: Usuario y/o contraseña incorrectos"+e;
        } finally{
            try {
                 if (getConexion()!= null) getConexion().close();
                 if (pst!=null) pst.close();
                 if (rs!= null) rs.close();
            } catch (Exception e) {
                error = "Error: No se ha podido cerrar la conexion "+e;
            }   
        }
        usuarioActual=null;     
        return usuarioActual;
    }  
    
    public boolean agregarCliente(String usuario, String nombre, String apellido, String email, String pass, String telefono, String direccion, String tipo_usuario, Blob foto) {
        PreparedStatement pst= null;
        try {
            getConexion().setAutoCommit(false);
            String query= "INSERT INTO usuario (usuario,nombre,apellido,email,pass,telefono,direccion,tipo_usuario, foto_perfil) VALUES (?,?,?,?,?,?,?,?,?);";
            pst = getConexion().prepareStatement(query);
            pst.setString(1, usuario);
            pst.setString(2, nombre);
            pst.setString(3, apellido);
            pst.setString(4, email);
            pst.setString(5, pass);
            pst.setString(6, telefono);
            pst.setString(7, direccion);
            pst.setString(8, tipo_usuario);
            pst.setBlob(9,foto);
            int ban=pst.executeUpdate();
            
            getConexion().commit();
            if(ban==1){
                return true;
            }
        } catch (SQLIntegrityConstraintViolationException e) {
            error = "Error: Nombre de usuario existente";
        } catch(Exception e){
            error= "Error: No se ha podido registrar nuevo usuario, intentelo nuevamente"+e;
        }finally {
            try {
                if (getConexion()!=null) getConexion().close();
                if (pst!=null) pst.close();
            } catch (Exception e) {
                error = "Error: No se ha podido cerrar la conexion "+e;
            }
        }
        return false;
                
    }
    public boolean modifUsuario(String usuario, String nombre, String apellido, String telefono, String mail, String pass, String tipoUsuario, String direccion, Blob foto) {
        PreparedStatement pst = null;
        ResultSet rs= null;
        try {
            pst = getConexion().prepareStatement("UPDATE Usuario SET pass=?, tipo_usuario = ? , nombre =?, apellido=?, telefono=?,email=?, direccion=?, foto_perfil=? WHERE usuario = ?");
            pst.setString(1,pass);
            pst.setString(2,tipoUsuario);
            pst.setString(3,nombre);
            pst.setString(4,apellido);
            pst.setString(5,telefono);
            pst.setString(6,mail);
            pst.setString(7,direccion);
            pst.setString(8,usuario);
            pst.setBlob(9,foto);
            
            
            if(pst.executeUpdate()==1){
                return true;
            }
        } catch (SQLException e) {
            error = "Error: No se ha podido modificar el usuario"+e;
        } finally{
            try{
                if (pst!=null) pst.close();
                if (getConexion()!=null) getConexion().close();
                if (rs!= null) rs.close();
            } catch(SQLException e) {
                error = "Error: No se ha podido cerrar la conexion"+e;
                }
        }
        return false;
    }
      
     public boolean existeCuenta(String email){
        PreparedStatement pst = null;
        ResultSet rs = null;
       
        
         try {
            String query = "SELECT * FROM usuario WHERE email = ?";
            Connection conexion = getConexion();
            pst = conexion.prepareStatement(query);
            pst.setString(1, email);
            rs = pst.executeQuery();
            
            if (rs.absolute(1)){
                
                return true;
            }
        } catch (Exception e) {
            error = "Error: Ya existe una cuenta con ese email, elija otro por favor."+e;
        } finally{
            try {
                 if (getConexion()!= null) getConexion().close();
                 if (pst!=null) pst.close();
                 if (rs!= null) rs.close();
            } catch (Exception e) {
                error = "Error: No se ha podido cerrar la conexion "+e;
            }   
        }
        return false;
    }   
     
     public boolean existeUsuario(String usuario){
        PreparedStatement pst = null;
        ResultSet rs = null;
                
         try {
            String query = "SELECT * FROM usuario WHERE usuario = ?";
            Connection conexion = getConexion();
            pst = conexion.prepareStatement(query);
            pst.setString(1, usuario);
            rs = pst.executeQuery();
            
            if (rs.absolute(1)){
                                
                return true;
            }
        } catch (Exception e) {
            error = "Error: Usuario ingresado ya existe, elija otro por favor. "+e;
        } finally{
            try {
                 if (getConexion()!= null) getConexion().close();
                 if (pst!=null) pst.close();
                 if (rs!= null) rs.close();
            } catch (Exception e) {
                error = "Error: "+e;
            }   
        }
          
        return false;
    } 
    
         
}
