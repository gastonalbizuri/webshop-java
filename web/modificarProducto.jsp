<%-- 
    Document   : modificarProducto
    Created on : 19/09/2020, 20:05:43
    Author     : maiic
--%>
<%@page import="Negocio.Usuario"%>
<%@page import="Negocio.Producto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession objSesion = request.getSession(false);
    Usuario usuarioActual = (Usuario) objSesion.getAttribute("userActual");
    Producto productoActual = (Producto) objSesion.getAttribute("prodActual");
    String error = "";
    
    if(usuarioActual == null){
        response.sendRedirect("index.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modificar Datos</title>
        <link rel="stylesheet" href="css/general.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    </head>
    <body>
        <%if (usuarioActual.getTipoUsuario().equals("administrador")){ %>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href="indexlogueado.jsp"><img class="logo-navbar" src="img/logo-abreviado.png"></img></a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="indexlogueado.jsp">Home
                            <span class="sr-only">(current)</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="productosABM.jsp">Productos</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="listadoPedidosAdmin.jsp">Pedidos</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="perfil.jsp">Hola, <%=usuarioActual.getUsuario()%></a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <%}%>
 
    
  <!-- Page Content -->
  <div class="container-profile">
        <div class ="row justify-content-center" >
            <form action="ModificarProductos" method="post" enctype="multipart/form-data">
                <h3 id="modif">Modificar Productos</h3>
                    
                <%if (objSesion.getAttribute("error") != null){ 
                    error = (String) objSesion.getAttribute("error");%>
                    <div id="notificacion" class="alert alert-danger" role="alert">
                        <label align="center"><%=error%></label>
                    </div>
                <%}%>
                <%objSesion.removeAttribute("error");%>
                
                
                <label for="exampleCodigoProd">Codigo</label>
                <input type="text" class="form-control" id="exampleCodigoProd" name="codigo" aria-describedby="codigoHelp" value="<%=productoActual.getID()%>" disabled><br>
                
                <label for="exampleNombreProducto">Titulo Producto</label>
                <input type="text" class="form-control" id="exampleNombreProducto" name="nombreProducto" aria-describedby="nombreHelp" value="<%=productoActual.getNombre()%>" ><br>
                        
                <label for="exampleDescripcion">Descripcion Producto</label>
                <input type="text" class="form-control" id="exampleDescripcion" name="descripcion" aria-describedby="descripcionHelp" value="<%=productoActual.getDescripcion()%>"><br>
                        
                <label for="examplePrecioProducto">Precio Producto</label>
                <input type="text" class="form-control" id="examplePrecioProducto" name="precioProducto" aria-describedby="precioHelp" value="<%=productoActual.getPrecio()%>"><br>
                
                <label for="exampleCategoria">Categoría</label><br>
                        <select name="categoria">
                            <option value="<%=productoActual.getCategoria()%>"><%=productoActual.getCategoria()%></option>
                            <option value="Bebidas">Bebidas</option>
                            <option value="Carniceria y pescaderia">Carnicería y pescadería</option>
                            <option value="Fiambres y salchichas">Fiambres y salchichas</option>
                            <option value="Lacteos y quesos">Lácteos y quesos</option>
                            <option value="Panaderia bolleria industrial">Panadería bollería industrial</option>
                            <option value="Productos de limpieza">Productos de limpieza</option>
                            <option value="Perfumeria">Perfumería</option>
                        </select><br><br>
                
                <input type="hidden" name="imagen" value="<%=productoActual.getFoto()%>">
                        
                <div class="form-group" id="modificar-datos-button"> 
                    <a type="button"  class="btn btn-secondary" href="productosABM.jsp">Cancelar</a>
                    <button type="submit"  class="btn btn-primary">Modificar</button>
                    
                </div>
                 
                
                    
            </form>
        </div>
    </div>
  
  <!-- /.container -->


  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
