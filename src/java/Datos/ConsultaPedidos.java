/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Datos;

import Negocio.*;
import java.sql.Blob;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;

/**
 *
 * @author Diana
 */
public class ConsultaPedidos extends Conexion{
    
    private String error=null;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
    
     public boolean RegistroPedido(String usuario, Pedido pedido) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        Calendar c2 = new GregorianCalendar();
        String fec = Integer.toString(c2.get(Calendar.YEAR))+"-"+Integer.toString(c2.get(Calendar.MONTH))+"-"+Integer.toString(c2.get(Calendar.DATE));
        java.sql.Date fecha = java.sql.Date.valueOf(fec);
        ArrayList<Linea_pedido> lineas = new ArrayList<Linea_pedido>();
        lineas = pedido.getLineas();
         
 
        try{
            getConexion().setAutoCommit(false);
            String consulta= "INSERT INTO pedido (usuario_cliente,fecha_pedido,orden_completa,total) VALUES (?,?,?,?);";
            pst = getConexion().prepareStatement(consulta);
            pst.setString(1, usuario);
            pst.setDate(2, fecha);
            pst.setString(3, "Orden completada");
            pst.setFloat(4, pedido.getPrecio());
            
            int ban=pst.executeUpdate();
            
            String consulta2="select p.id_pedido from pedido p where usuario_cliente=? and fecha_pedido = ?;";
            pst =getConexion().prepareStatement(consulta2);
            pst.setString(1, usuario);
            pst.setDate(2, fecha);
            rs = pst.executeQuery();
            int numPedido=0;
            while (rs.next()){
                numPedido=rs.getInt("id_pedido");
            }
            
            int ban2=1;
            for (int i=0;i<lineas.size();i++){
                String consulta3="insert into linea_pedido (id_linea,id_producto,id_pedido,cantidad) values (?,?,?,?)";
                pst = getConexion().prepareStatement(consulta3);
                pst.setInt(1, lineas.get(i).getNumeroLinea());
                pst.setInt(2, lineas.get(i).getProducto().getID());
                pst.setInt(3, numPedido);
                pst.setInt(4, lineas.get(i).getCantidad());
                int band=pst.executeUpdate();
                if (band==0){
                    ban2=0;
                }
            }
            
            getConexion().commit();
            if(ban==1 && ban2==1){
                return true;
            }

        }catch (Exception e) {
            error = "Error: No se ha podido registrar el pedido"+e;
        } finally {
            try {
                if (getConexion()!=null) getConexion().close();
                if (pst!=null) pst.close();
                if (rs!=null) rs.close();
            } catch (SQLException e) {
                error = "Error: Problemas al cerrar conexion"+e;
            }
        }
        
        
        return false;  
    }

    public ArrayList<Pedido> listadoPedidosAdmin()throws SQLException, SQLException{
        PreparedStatement st= null;
        ArrayList<Pedido> pedidos = new ArrayList<Pedido>();
        Pedido pedidoActual = null;
        Usuario cliente = null;
        ArrayList<Linea_pedido> lineasPedido  = new ArrayList<Linea_pedido>();
        Linea_pedido lineaActual = null;
        Producto prodAct = null;
        ResultSet rs= null;
        try{
            String consulta = "SELECT * FROM pedido p"+
                " INNER JOIN linea_pedido lp ON p.id_pedido = lp.id_pedido"+
                " INNER JOIN producto pr ON lp.id_producto = pr.id_producto"+ 
                " INNER JOIN usuario u ON p.usuario_cliente = u.usuario"+
                " ORDER BY p.fecha_pedido asc";
            st= getConexion().prepareStatement(consulta);
            rs = st.executeQuery();
            int idPed = 0;
            while (rs.next()){

                int idlinea = rs.getInt("id_linea");
                int idpedido = rs.getInt("id_pedido");
                int cant = rs.getInt("cantidad");
                int idProd = rs.getInt("id_producto");
                String nombreProducto = rs.getString("pr.nombre");
                String descProducto= rs.getString("descripcion");
                String categ =rs.getString("categoria");
                float precioProducto = rs.getFloat("precio");
                Blob imagenProducto = rs.getBlob("foto");
                prodAct = new Producto(idProd,nombreProducto,descProducto,precioProducto,imagenProducto,categ);
                if (idpedido!= idPed){
                    lineasPedido = new ArrayList<Linea_pedido>();
                }  
                lineaActual = new Linea_pedido();
                lineaActual.setNumeroLinea(idlinea);
                lineaActual.setProducto(prodAct);
                lineaActual.setCantidad(cant);
                lineasPedido.add(lineaActual);
                java.sql.Date fechaPed = rs.getDate("fecha_pedido");
                String orden = rs.getString("orden_completa");
                float totalPedido = rs.getFloat("total");
                String usuCli = rs.getString("usuario_cliente");
                String conCli = rs.getString("pass");
                String tipoCli = rs.getString("tipo_usuario");
                String nomCli = rs.getString("u.nombre");
                String apeCli = rs.getString("apellido");
                String telCli = rs.getString("telefono");
                String mailCli = rs.getString("email");
                String direc = rs.getString("direccion");
                Blob foto = rs.getBlob("foto_perfil");
                
                if (idpedido!= idPed){
                    cliente = new Usuario(usuCli, conCli, tipoCli,nomCli, apeCli, telCli, mailCli,direc, foto );
                    pedidoActual = new Pedido();
                    pedidoActual.setId(idpedido);
                    pedidoActual.setFechaPedido(fechaPed);
                    pedidoActual.setOrdenCompleta(orden);
                    pedidoActual.setCliente(cliente);
                    pedidoActual.setLineas(lineasPedido);
                    pedidos.add(pedidoActual);
                    idPed=idpedido;
                }
                
            }
            
        }catch (Exception e) {
            error = "Error: No se ha podido listar su solicitud "+e;
        }finally{
            try{
                if (getConexion()!=null) getConexion().close();
                if (st!=null) st.close();
                if (rs!=null) rs.close();
            }catch (SQLException e){
                error = "Error: No se ha podido cerrar la conexion correctamente "+e;
            }
        }
        return pedidos;    
    }
    
    public ArrayList<Pedido> listadoPedidosCliente(String usuario) throws SQLException, SQLException{
        PreparedStatement st= null;
        ArrayList<Pedido> pedidos = new ArrayList<Pedido>();
        Pedido pedidoActual = null;
        Usuario cliente = null;
        ArrayList<Linea_pedido> lineasPedido  = new ArrayList<Linea_pedido>();
        Linea_pedido lineaActual = null;
        Producto prodAct = null;
        ResultSet rs= null;
        try {
            String consulta = "SELECT * FROM pedido p"+
                " INNER JOIN linea_pedido lp ON p.id_pedido = lp.id_pedido"+
                " INNER JOIN producto pr ON lp.id_producto = pr.id_producto"+ 
                " INNER JOIN usuario u ON p.usuario_cliente = u.usuario"+
                " where p.usuario_cliente = ? order by p.id_pedido desc , lp.id_linea desc";
            st= getConexion().prepareStatement(consulta);
            st.setString(1, usuario);
            rs = st.executeQuery();
            int idPed = 0;
            while (rs.next()){
                int idlinea = rs.getInt("id_linea");
                int idpedido = rs.getInt("id_pedido");
                int cant = rs.getInt("cantidad");
                int idProd = rs.getInt("id_producto");
                String nombreProducto = rs.getString("pr.nombre");
                String descProducto= rs.getString("descripcion");
                String categ =rs.getString("categoria");
                float precioProducto = rs.getFloat("precio");
                Blob imagenProducto = rs.getBlob("foto");
               prodAct = new Producto(idProd,nombreProducto,descProducto,precioProducto,imagenProducto,categ);
                if (idpedido!= idPed){
                    lineasPedido = new ArrayList<Linea_pedido>();
                }  
                 lineaActual = new Linea_pedido();
                lineaActual.setNumeroLinea(idlinea);
                lineaActual.setProducto(prodAct);
                lineaActual.setCantidad(cant);
                lineasPedido.add(lineaActual);
           
                java.sql.Date fechaPed = rs.getDate("fecha_pedido");
                String orden = rs.getString("orden_completa");
                float totalPedido = rs.getFloat("total");
                String usuCli = rs.getString("usuario_cliente");
                String conCli = rs.getString("pass");
                String tipoCli = rs.getString("tipo_usuario");
                String nomCli = rs.getString("u.nombre");
                String apeCli = rs.getString("apellido");
                String telCli = rs.getString("telefono");
                String mailCli = rs.getString("email");
                String direc = rs.getString("direccion");
                Blob foto = rs.getBlob("foto_perfil");
                
                if (idpedido!= idPed){
                    cliente = new Usuario(usuCli, conCli, tipoCli,nomCli, apeCli, telCli, mailCli,direc, foto );
                    pedidoActual = new Pedido();
                    pedidoActual.setId(idpedido);
                    pedidoActual.setFechaPedido(fechaPed);
                    pedidoActual.setOrdenCompleta(orden);
                    pedidoActual.setCliente(cliente);
                    pedidoActual.setLineas(lineasPedido);
                    pedidos.add(pedidoActual);
                    idPed=idpedido;
                }
            }    
        } catch (Exception e) {
            error = "Error: No se ha podido listar su solicitud "+e;
        }finally{
           try {
                if (getConexion()!=null) getConexion().close();
                if (st!=null) st.close();
                if (rs!=null) rs.close();
            } catch (SQLException e) {
                error = "Error: No se ha podido cerrar la conexion correctamente "+e;
            }
        }
        return pedidos;
    }
   
     
}