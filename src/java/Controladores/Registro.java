/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controladores;

import Datos.ConsultaUsuario;
import Negocio.Usuario;
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
 * @author Usuario
 */
@MultipartConfig
public class Registro extends HttpServlet {

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
        
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String usuario = request.getParameter("usuario");
        String pass = request.getParameter("contrasena");
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");
        Part part = request.getPart("imagen");
        
        InputStream inputStream = part.getInputStream();
        
        byte[] blob = IOUtils.toByteArray(inputStream);
        Blob foto = new SerialBlob(blob);
        
        ConsultaUsuario usu1 = new ConsultaUsuario();
        ConsultaUsuario usu2 = new ConsultaUsuario();
              
        if (usu1.existeCuenta(email)){
                usu1.setError("Ya existe una cuenta con ese email, elija otro por favor.");
                sesion.setAttribute("errorRegistro", usu1.getError());
                ban = false;
            };
        if(usu2.existeUsuario(usuario)){
                usu2.setError("Usuario ingresado ya existe, elija otro por favor.");
                sesion.setAttribute("errorRegistro", usu2.getError());
                ban = false;
            }
             
       ConsultaUsuario usu = new ConsultaUsuario();
        
        if(ban==true){
                usu.agregarCliente(usuario, nombre, apellido, email, pass, telefono, direccion, "Cliente", foto);
                sesion.setAttribute("exitoRegistro", "Registro realizado");
                response.sendRedirect("login.jsp"); 
            }
            
        
        else{
            usu.setError("No se ha podido registrar nuevo usuario, intentelo nuevamente");
            sesion.setAttribute("errorRegistro",usu.getError());
            response.sendRedirect("registroNuevo.jsp");
             
            
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
            Logger.getLogger(Registro.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(Registro.class.getName()).log(Level.SEVERE, null, ex);
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
