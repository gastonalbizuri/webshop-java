/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Negocio;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
/**
 *
 * @author Usuario
 */
public class Pedido {
    
    private int idpedido;
    private Date fecha_pedido;
    private String orden_completa;
    private float precio;
    private Usuario cliente;
    private ArrayList<Linea_pedido> lineas;   
    
    
   
    
    
    public Pedido(int idped, Date fecha, String completa, Usuario cli, ArrayList<Linea_pedido> lin){
        
        this.idpedido = idped;
        this.fecha_pedido = fecha;
        this.orden_completa = completa;  
        this.cliente = cli;
        this.lineas = lin;
    }

    public Pedido() {
      
    }

    

    public Pedido(int idpedido, Usuario cliente, java.sql.Date fechaPed, String orden, float totalPedido, ArrayList<Linea_pedido> lineasPedido) {
        
    }

    
    
    public int getId() {
        return idpedido;
    }

    public void setId(int idped) {
        this.idpedido = idped;
        
    }
    public Date getFechaPedido(){
        return fecha_pedido;
    }
    
    public void setFechaPedido(Date fecha){
        
        this.fecha_pedido = fecha;
    } 
    
    public String getOrdenCompleta(){
        return orden_completa;
    }
    
    public void setOrdenCompleta(String completa){
        this.orden_completa = completa;
    }
    
    public String getUsuarioCliente() {
        return cliente.getUsuario();
    }
    
    
    public void setCliente(Usuario cli) {
        this.cliente = cli;
    }
    
    public ArrayList<Linea_pedido> getLineas() {
        return lineas;
    }

    public void setLineas(ArrayList<Linea_pedido> lineas) {
        this.lineas = lineas;
    }
    
    public float getPrecio() {
        return precio;
    }
    
    public void setPrecio() {
        float total = 0;
        if (lineas!=null){
            for (int i=0;i<lineas.size();i++){
                total= total+(lineas.get(i).getCantidad()*lineas.get(i).getProducto().getPrecio());
            }
       
        }
        precio = total;
    }
    
    public void borrarLinea(int num){
        for (int i=0;i<lineas.size();i++){
            if (lineas.get(i).getNumeroLinea()==num){
                lineas.remove(i);
            }
        }
    }
    
    
    public String getApellidoCliente() {
        return cliente.getApellido();
    }
    public String getNombreCliente() {
        return cliente.getNombre();
    }
    
    public String getTelefonoCliente(){
        return cliente.getTelefono();
    }
    
    public String getMailCliente(){
        return cliente.getMail();
    }

    
    
}
