<%-- 
    Document   : carrito
    Created on : 24-sep-2020, 20:41:31
    Author     : Diana
--%>

<%@page import="Negocio.Linea_pedido"%>
<%@page import="Negocio.Pedido"%>
<%@page import="Negocio.Usuario"%>
<%@page import="Datos.ConsultaProductos"%>
<%@page import="Negocio.Producto"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession objSesion = request.getSession(false);
    Pedido pedido = (Pedido) objSesion.getAttribute("pedidoActual");
    Usuario usuarioActual = (Usuario) objSesion.getAttribute("userActual");
       
%>
<!DOCTYPE html>

<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Albicar</title>
  
 <link href="css/general.css" rel="stylesheet" type="text/css"/>
  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="css/shop-homepage.css" rel="stylesheet">

  

</head>

<body>

  <!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="index.jsp"><img class="logo-navbar" src="img/logo-abreviado.png"></img></a>
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

  <!-- Page Content -->
  <div class="container-profile">
      <%if(pedido != null){%>
    <div class ="form-group" >
        
            <h3 id="pedido">Mi pedido</h3>
            
            <table class="table table-striped" id="tablaListadoPedidos">
                <thead>
                    <tr>
                        <th scope="col">Código</th>
                        <th scope="col">Nombre</th>
                        <th scope="col">Precio</th>
                        <th scope="col">Categoría</th>
                        <th scope="col">Cantidad</th>
                        <th scope="col"></th>
                        
                    </tr>
                </thead>
                <tbody>
                    <%ArrayList<Linea_pedido> lineas = new ArrayList<Linea_pedido>();
                    lineas = pedido.getLineas(); 
                    for (int i=0;i<lineas.size();i++){%>
                    
                   <tr>
                     <td scope="row" ><%=lineas.get(i).getProducto().getID()%></td>
                     <td><%=lineas.get(i).getProducto().getNombre()%></td>
                     <td><%=lineas.get(i).getProducto().getPrecio()%></td>
                     <td><%=lineas.get(i).getProducto().getCategoria()%></td>
                    <!-- <td></td> -->
                     <td>
                           <form action="ActualizarProducto"  method="post">
                             <input type="hidden" name="numeroLinea" value="<%=lineas.get(i).getNumeroLinea()%>">  
                             <input type="text" name="cantidad" id="cantidad" size="1" value="<%=lineas.get(i).getCantidad()%>">
                             <input type="submit" id="act-button" class="btn btn-primary" value="Actualizar">
                           </form>
                     </td>
                     <td>
                           <form action="EliminarProducto" method="post">
                             <input type="hidden" name="numeroLinea" value="<%=lineas.get(i).getNumeroLinea()%>">
                             <input type="submit" class="btn btn-primary" style="background-color:red; border-color:red; color:white" value="Eliminar">
                           </form>
                     </td>
                   </tr>
                    <%}%>
                    </tbody>
               </table>
                    <br><br>
                    <div class="row justify-content-between" id="volver-button">
                        <a type="button" href="carrito.jsp" class="btn btn-secondary">Volver</a>
                    </div> 
               <td>
        
    </div>
                     <%} else { response.sendRedirect("carrito.jsp"); }%>
  </div>
               
</body>

</html>