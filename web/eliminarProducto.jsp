<%-- 
    Document   : eliminarProducto
    Created on : 21/09/2020, 21:42:15
    Author     : maiic
--%>
<%@page import="Negocio.Usuario"%>
<%@page import="Negocio.Producto"%>
<%@page import="java.util.Base64"%>
<%@page import="java.util.*" %>
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
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Albicar</title>
  
  <link rel="stylesheet" href="css/general.css">
  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="css/shop-homepage.css" rel="stylesheet">

</head>

<body>

  <!-- Navigation -->
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
            <a class="nav-link" href="perfil.jsp">Hola, <%=usuarioActual.getUsuario()%> </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

 
  <!-- Page Content -->
 <div class="container-profile">
    <div id="altaproduc" class="row justify-content-center">
            <%if (objSesion.getAttribute("error") != null){ 
                    error = (String) objSesion.getAttribute("error");%>
                    <div id="notificacion" class="alert alert-danger" role="alert">
                        <label align="center"><%=error%></label>
                    </div>
                <%}%>
                <%objSesion.removeAttribute("error");%>
            <h3>Está seguro que desea eliminar el siguiente producto?</h3>
    </div>
    <div class ="row justify-content-center" >
        <form action="BajaProducto" method="post" enctype="multipart/form-data">
            
            
            <img class="img-delete" src="data:image/jpg;base64,<%=productoActual.base64Image%>"/><br>
            <label for="exampleCodigoProd">Codigo: <%=productoActual.getID()%></label><br>
            <label for="exampleCodigoProd">Nombre: <%=productoActual.getNombre()%></label><br>
            <label for="exampleCodigoProd">Descripcion: <%=productoActual.getDescripcion()%></label><br>
            <label for="exampleCodigoProd">Precio $<%=productoActual.getPrecio()%></label><br>
            <br>
        <div class="form-group" id="modificar-datos-button"> 
            <a type="button"  class="btn btn-secondary" href="productosABM.jsp">Cancelar</a>
            <button type="submit"  class="btn btn-primary">Eliminar</button>
                    
        </div>
        </form>
    </div>
  <!-- /.container -->
</div>


  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>


