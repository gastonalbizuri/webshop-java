<%-- 
    Document   : bebidas
    Created on : 27-sep-2020, 20:50:10
    Author     : Diana
--%>
<%@page import="Negocio.Usuario"%>
<%@page import="Datos.ConsultaProductos"%>
<%@page import="Negocio.Producto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Base64"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession objSesion = request.getSession(true);
    Usuario usuarioActual = (Usuario) objSesion.getAttribute("userActual");
    String notificacion = "";
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

  <!-- Navigation  -->
  <%if(usuarioActual == null){%>
 <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="index.jsp"><img class="logo-navbar" src="img/logo-abreviado.png"></img></a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item active">
            <a class="nav-link" href="index.jsp">Home
              <span class="sr-only">(current)</span>
            </a>
          </li>
           <li class="nav-item">
            <a class="nav-link" href="login.jsp">Iniciar Sesión</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <%}%>
  <%if(usuarioActual != null){%>
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
            <a class="nav-link" href="listadoProductos.jsp">Productos</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="carrito.jsp">Pedidos</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="listadoPedidosCliente.jsp">Lista de Pedidos</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="perfil.jsp">Hola, <%=usuarioActual.getUsuario()%></a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <%}%>        
          
 <div class="container">
     <a type="submit" class="btn btn-success" id="seguir-comprando" href="listadoProductos.jsp">← Volver</a>
     <h3 align="center">Bebidas</h3>
     <% ArrayList<Producto> prod = new ArrayList<Producto>(); prod = null;
            ConsultaProductos productos = new ConsultaProductos();
            prod = productos.buscarCategoria("Bebidas"); %>
            <br>
            <br>
            <br>
            
            
    <div class="row justify-content-center">
        
        
        <div class="col-lg-9">
            <%if (objSesion.getAttribute("notificacion") != null){
                notificacion = (String) objSesion.getAttribute("notificacion"); %>
                <div id="notificacion" class="alert alert-success" role="alert">
                    <label align="center"><%=notificacion%></label>
                </div>
            <%}%>
            <%objSesion.removeAttribute("notificacion");%>
            
            <div class="row">
        
                
 
            <%for(int i=0;i<prod.size();i++ ){%>
                <div class="col-lg-4 col-md-6 mb-4">
                  <div class="card h-100">
                    <a href="#"><img class="card-img-top" src="data:image/jpg;base64,<%=prod.get(i).base64Image%>" alt=""></a>
                    <div class="card-body">
                         
                      <h4 class="card-title">
                         <%if(usuarioActual != null){%> 
                        <a href="#"><%=prod.get(i).getNombre()%></a>
                         <%} else{%>
                        <a href="login.jsp"><%=prod.get(i).getNombre()%></a> 
                        <%}%>
                      </h4>
                      <h5><%=prod.get(i).getPrecio()%></h5>
                      <p class="card-text"><%=prod.get(i).getDescripcion()%></p>
                    </div>
                    <form action="AgregarProducto" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="idProducto" value="<%=prod.get(i).getID()%>">
                        <input type="hidden" name="nombreProducto" value="<%=prod.get(i).getNombre()%>">
                        <input type="hidden" name="descripcionProducto" value="<%=prod.get(i).getDescripcion()%>">
                        <input type="hidden" name="precioProducto" value="<%=prod.get(i).getPrecio()%>">
                        <input type="hidden" name="imagenProducto" value="<%=prod.get(i).base64Image%>">
                        <input type="hidden" name="categoriaProducto" value="<%=prod.get(i).getCategoria()%>">
                        <%if(usuarioActual != null){%>
                        <label id="cantidad">Cantidad: </label>     <input type="text" name="cantidad" id="cantidad" size="1">
                        <div class="card-footer">    
                            <input type="submit" class="btn btn-primary" id="carrito-button" value="Agregar carrito">
                        </div>
                        <%}%>
                    </form>   
                    
                  </div>
                </div>
               <%}%>
              
             
          
            
            </div>
        <!-- /.row -->

      </div>
      <!-- /.col-lg-9 -->

    </div>
    <!-- /.row -->

  </div>
  <!-- /.container -->
  
</body>
</html>