/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controladores;

import Negocio.Linea_pedido;
import Negocio.Pedido;
import Negocio.Producto;
import Negocio.Usuario;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
import javax.sql.rowset.serial.SerialBlob;
import org.apache.commons.io.IOUtils;


@MultipartConfig
public class AgregarProducto extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession sesion = request.getSession(true);
        
        Integer num;
        if (sesion.getAttribute("numeroLinea")== null){
            sesion.setAttribute("numeroLinea",1);
            num=1;
        }
        else{
            num=(Integer) sesion.getAttribute("numeroLinea");
            num=num+1;
            sesion.setAttribute("numeroLinea", num);
        }
        String cantidad = request.getParameter("cantidad");
        if (cantidad.equals("")){
            sesion.setAttribute("error","Error: Ingrese la cantidad a comprar");
            response.sendRedirect("carrito.jsp");
        }
        else if (!cantidad.matches( "[1-9]|[1-2][0-9]|" )){
            sesion.setAttribute("error","Error: Ingrese una cantidad correcta y menor a 30 unidades");
            response.sendRedirect("carrito.jsp");
        }
        else{
            Usuario cliente = (Usuario) sesion.getAttribute("userActual");
            int id = Integer.parseInt(request.getParameter("idProducto"));
            String nombre = request.getParameter("nombreProducto");
            String descripcion = request.getParameter("descripcionProducto");
            Float precio = Float.parseFloat(request.getParameter("precioProducto"));
            Part part = request.getPart("imagenProducto");
            String cat = request.getParameter("categoriaProducto");
            InputStream inputStream = part.getInputStream();
            int cant = Integer.parseInt(request.getParameter("cantidad"));
            
            byte[] blob =IOUtils.toByteArray(inputStream);
            Blob foto = new SerialBlob(blob);
        
            Producto producto = new Producto(id,nombre,descripcion,precio,foto,cat);
            Linea_pedido lp = new Linea_pedido(num, producto, cant);
            ArrayList<Linea_pedido> lineas = new ArrayList<>();
            Pedido pedActual =  new Pedido();
        
            if (sesion.getAttribute("pedidoActual")== null){
                pedActual.setCliente(cliente);
                pedActual.setLineas(lineas);
            }
            else{
               pedActual = (Pedido) sesion.getAttribute("pedidoActual");
            }
            lineas=pedActual.getLineas();
            lineas.add(lp);
            pedActual.setLineas(lineas);
            pedActual.setPrecio();
            sesion.setAttribute("pedidoActual", pedActual);
            sesion.setAttribute("notificacion", "Objeto ingresado al carrito!");
            response.sendRedirect(request.getHeader("referer"));
        }
    }
/*response.encodeRedirectURL(request.getRequestURI())*/
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
            Logger.getLogger(AgregarProducto.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(AgregarProducto.class.getName()).log(Level.SEVERE, null, ex);
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

