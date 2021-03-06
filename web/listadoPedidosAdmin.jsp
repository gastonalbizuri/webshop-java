<%-- 
    Document   : listadoPedidosAdmin
    Created on : 04/10/2020, 15:52:54
    Author     : maiic
--%>

<%@page import="Negocio.Usuario"%>
<%@page import="Datos.ConsultaPedidos"%>
<%@page import="Negocio.Pedido"%>
<%@page import="Negocio.FormatDate"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Base64"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession objSesion = request.getSession(false);
    Usuario usuarioActual = (Usuario) objSesion.getAttribute("userActual");
    objSesion.removeAttribute("error");
    String tipoUsuario = usuarioActual.getTipoUsuario();
    if(usuarioActual.getUsuario().equals("")|| tipoUsuario.equals("Cliente")){
       response.sendRedirect("indexlogueado.jsp");
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
<%if (usuarioActual.getTipoUsuario().equals("administrador")){ %>
  <!-- Navigation  -->
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
 <div class="container-profile">
      <a type="submit" class="btn btn-secondary" id="seguir-comprando" href="indexlogueado.jsp">??? Volver</a>

    <div class ="row justify-content-center" >
            <h3 id="pedido">Listado de pedidos de Clientes</h3>
            
            <table class="table table-striped" id="tablaListadoPedidos">
                <thead>
                    <tr>
                        <th scope="col">Datos del Cliente</th>
                        <th scope="col">Datos del pedido</th>
                        <th scope="col">Productos</th>
                    </tr>
                </thead>
                <tbody>
                    <% ArrayList<Pedido> pedidos = new ArrayList<Pedido>();
                     ConsultaPedidos ped = new ConsultaPedidos();
                     pedidos = ped.listadoPedidosAdmin();
                    
                    for (int i=0;i<pedidos.size();i++){%>
                   <tr>
                     <td><b>Usuario:</b> <%=pedidos.get(i).getUsuarioCliente()%>
                     <br><br><b>Nombre:</b> <%=pedidos.get(i).getNombreCliente()%> <%=pedidos.get(i).getApellidoCliente()%>
                     <br><br><b>Tel??fono:</b> <%=pedidos.get(i).getTelefonoCliente()%>
                     <br><br><b>Mail:</b> <%=pedidos.get(i).getMailCliente()%></td>
                     
                     <td><b>N??mero de Pedido:</b> <%=pedidos.get(i).getId()%>
                     <br><br><b>Fecha Pedido:</b> <%=FormatDate.FechaFormato(pedidos.get(i).getFechaPedido())%></td>
                     
                     <td><% for (int j=0;j<pedidos.get(i).getLineas().size();j++){%>
                         
                         <b>Nombre Producto:</b> <%=pedidos.get(i).getLineas().get(j).getProducto().getNombre()%>
                         <br><br><b>Precio Unitario:</b> $<%=pedidos.get(i).getLineas().get(j).getProducto().getPrecio()%>
                     <br><br><b>Categoria:</b> <%=pedidos.get(i).getLineas().get(j).getProducto().getCategoria()%>
                     <br><br><b>Cantidad:</b> <%=pedidos.get(i).getLineas().get(j).getCantidad()%><br><br>
                     ---------------------------------------------- <br>
                     <%}%>
                     <br><br><b> Total</b> <%pedidos.get(i).setPrecio();%>
                            $<%=String.format("%.2f",pedidos.get(i).getPrecio())%></td>             
                    
                   </tr>
                   <%}%>
                    
                </tbody>
            </table>
    </div>
    <br><br>
    <div class="row justify-content-center">
        <nav aria-label="Page navigation example">
            <ul class="pagination">
    <%    
    int pag = 1;
    //Al momento de dar siguiente o presionar otro bot??n, manda como parametro "pg" con el n??mero de p??gina.
    if (request.getParameter("pg") != null) {
        pag = Integer.valueOf(request.getParameter("pg"));
    } 
    //Elementos por p??gina.
    int maxPag = pedidos.size() / 9;
    //Aqu?? hago una operaci??n para obtener el n??mero de registro del que inicia.    
    int regMin = (pag - 1) * 9;
    //Aqu?? hago una operaci??n para obtener el n??mero de registros m??ximos para mostrar en esa p??gina.
    //Esto con el fin, de recorrer el arreglo desde el registro m??nimo hasta el registro m??ximo.
    int regMax = pag * 9;
%>

<% //Pregunto si hay m??s de una p??gina, para comenzar paginaci??n.
                    if (maxPag >= 1) {
                        //Si la p??gina diferente a uno, si agrega el bot??n anterior.
                        if(pag!=1){%>
                            <li class="page-item">
                                <a class="page-link" href="listadoPedidosCliente.jsp?pg=<%=pag - 1%>" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                    <span class="sr-only">Previous</span>
                                </a>
                            </li>
                            
                        <%}%>
                        <%//Realizo el for para calcular el m??ximo de p??ginas.
                            for (int i = 0; i < maxPag; i++) {
                            //Si la p??gina es igual a la p??gina actual, muestra la etiqueta active.
                                if(i+1==pag){
                        %>  
                            <li class="page-item active"><a class="page-link" href="#"><%=i+1%></a></li>
                            
                        <%  }//Si no, sigue mostrando las etiquetas normales con la opci??n para desplazarse.
                            else{%>
                                <li class="page-item"><a class="page-link" href="listadoPedidosCliente.jsp?pg=<%=i+1%>"><%=i+1%></a></li>
                        <%}}
                        //S?? pagina es diferente al n??mero m??ximo de p??ginas, muestra la opci??n siguiente.
                        if(pag!=maxPag){%>
                           <li class="page-item">
                            <a class="page-link" href="listadoPedidosCliente.jsp?pg=<%=pag + 1%>" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                                <span class="sr-only">Next</span>
                            </a>
                        </li>
                            
                <%}}//Si el m??ximo de p??ginas no es mayor a 1, muestra solo una p??gina 
                    else {%>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                <%}
                %>    
            </ul>
        </nav>    
    </div>  
  </div>
  <!-- /.container -->

 

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>