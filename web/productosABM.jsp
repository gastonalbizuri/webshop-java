<%@page import="Negocio.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession objSesion = request.getSession(false);
    Usuario usuarioActual = (Usuario) objSesion.getAttribute("userActual");
    String notificacion = "";
    String modificacion = "";
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
            <a class="nav-link" href="perfil.jsp">Hola, <%=usuarioActual.getUsuario()%></a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

 
  <!-- Page Content -->
 <div class="container-profile">
    
    <div id="product-abm" class="row justify-content-center">
        <h3>ABM de Productos</h3>
            <% if (objSesion.getAttribute("exitoAltaProd") != null){
                    notificacion = (String) objSesion.getAttribute("exitoAltaProd");%>
                    <div class="alert alert-success" role="alert">
                        <label align="center"><%=notificacion%></label>
                    </div>                 
            <%}%>
            <%objSesion.removeAttribute("exitoAltaProd");%>
            
            <% if (objSesion.getAttribute("notificacionModif") != null){
                    modificacion = (String) objSesion.getAttribute("notificacionModif");%>
                <div class="alert alert-success" role="alert">
                    <label align="center"><%=modificacion%></label>
                </div>                 
            <%}%>
            <%objSesion.removeAttribute("notificacionModif");%>
    </div>
    <br>
    <div class="row justify-content-center">
        <div class="col-lg-3">
            <a type="button" id="button-abmproduct" class="btn btn-primary btn-lg btn-block" href="altaProducto.jsp">Agregar producto</a>
            <a type="button" id="button-abmproduct" class="btn btn-primary btn-lg btn-block" href="buscaProducto.jsp">Modificar producto</a>
            <a type="button" id="button-abmproduct" class="btn btn-primary btn-lg btn-block" href="buscaProductoEliminar.jsp">Eliminar producto</a>
            
        </div>
        
    </div>
  <!-- /.container -->
 </div>


  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>
