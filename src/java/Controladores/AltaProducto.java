/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controladores;

import Datos.ConsultaProductos;
import java.io.*;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.sql.rowset.serial.SerialBlob;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import org.apache.commons.io.IOUtils;

/**
 *
 * @author mzsol
 */

@MultipartConfig
public class AltaProducto extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter(); /**Devuelve un objeto PrintWriter que puede enviar textos al cliente */
        HttpSession sesion = request.getSession(true); /** crea la sesion */
        
        boolean ban = true;
        
        String codigo = request.getParameter("codigoProducto");
        String nombre = request.getParameter("nombreProducto");
        String desc = request.getParameter("descripcion");
        String precio = request.getParameter("precioProducto");
        Part part = request.getPart("imagen");
        String categoria = request.getParameter("categoria");
        InputStream inputStream = part.getInputStream();
        
        
        byte[] blob = IOUtils.toByteArray(inputStream);
        Blob foto = new SerialBlob(blob);
        int cod = Integer.parseInt(codigo);
        float prec = Float.parseFloat(precio);
        
        ConsultaProductos product = new ConsultaProductos();
        
        if(ban==true){
                product.agregarProducto(cod, nombre, desc, prec, foto, categoria);
                sesion.setAttribute("exitoAltaProd", "Producto dado de alta con exito");
                response.sendRedirect("productosABM.jsp"); 
            }
            
        
        else{
            product.setError("Error al agregar producto, revise los campos e intentelo nuevamente");
            sesion.setAttribute("errorAltaProd", product.getError());
            response.sendRedirect("altaProducto.jsp");
             
            
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
            Logger.getLogger(AltaProducto.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(AltaProducto.class.getName()).log(Level.SEVERE, null, ex);
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
