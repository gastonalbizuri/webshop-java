/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controladores;

import Datos.ConsultaProductos;
import Negocio.Producto;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.sql.rowset.serial.SerialBlob;
import org.apache.commons.io.IOUtils;

/**
 *
 * @author maiic
 */
@MultipartConfig
public class ModificarProductos extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        PrintWriter out = response.getWriter() ;
        HttpSession objSesion = request.getSession(false);
        
        String codigo = request.getParameter("codigo");
        String nombre = request.getParameter("nombreProducto");
        String descripcion = request.getParameter("descripcion");
        String precio = request.getParameter("precioProducto");
        String categoria = request.getParameter("categoria");
        Part part = request.getPart("imagen");
        InputStream inputStream = part.getInputStream();
        
        int cod = Integer.parseInt(codigo);
        float prec = Float.parseFloat(precio);
        byte[] blob = IOUtils.toByteArray(inputStream);
        Blob foto = new SerialBlob(blob);
       
        boolean ban;
        ConsultaProductos prod = new ConsultaProductos();
        
        if(prec <0){
            prod.setError("Error: Ingrese precio mayor a cero");
            objSesion.setAttribute("error",prod.getError());
            response.sendRedirect("buscaProducto.jsp");
        }
        else{
            ban = prod.modifProduct(cod, nombre,descripcion,prec, foto, categoria);
        
            
        if(ban){
                Producto productoActual = (Producto) objSesion.getAttribute("productoActual");
                productoActual = new Producto(cod,nombre,descripcion,prec, foto, categoria);
                objSesion.setAttribute("prodActual", productoActual);
                objSesion.setAttribute("notificacionModif", "Datos actualizados!");
                response.sendRedirect("productosABM.jsp");
            }
            else{
                prod.setError("Error al actualizar producto");
                objSesion.setAttribute("error",prod.getError());
                response.sendRedirect("modificarProducto.jsp");
            }  
        }      
    }
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ModificarProductos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ModificarProductos.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
