<%-- 
    Document   : buscaProducto
    Created on : 20/09/2020, 12:34:49
    Author     : maiic
--%>

<%@page import="Negocio.Usuario"%>
<a href="buscaProducto.jsp"></a>
<%@page import="Datos.ConsultaProductos"%>
<%@page import="Negocio.Producto"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession objSesion = request.getSession(false);
    Usuario usuarioActual = (Usuario) objSesion.getAttribute("userActual");
    if(usuarioActual == null){
        response.sendRedirect("index.jsp");
    }
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
    
    <div class ="row justify-content-center" >
        <form action="BuscarProductos" method="post">
            <h3 id="modif">Buscar Productos</h3>
            
            <label for="exampleCodigoProd">Código</label>
            <input type="text" class="form-control" id="exampleCodigoProd" name="codigo" aria-describedby="codigoHelp" required>
            <% if (objSesion.getAttribute("error") != null){
                   notificacion = (String) objSesion.getAttribute("error");%>
                    <div id="notificacion" class="alert alert-danger" role="alert">
                        <label align="center"><%=notificacion%></label>
                    </div>
                    <%}%>
                 <%objSesion.removeAttribute("error");%>       
                 <br><div class="form-group" id="modificar-datos-button"> 
            <a type="button"  class="btn btn-secondary" href="productosABM.jsp">Cancelar</a>
            <button type="submit"  class="btn btn-primary">Buscar</button>
             
        </div>
            
        </form>
    </div>
              <% ArrayList<Producto> prod = new ArrayList<Producto>(); prod = null;
            ConsultaProductos productos = new ConsultaProductos();
            prod = productos.listadoProductos(); %>
            
         
          <table class="table table-striped" id="tablaListado">
                 <thead>
                   <tr>
                     <th scope="col">Código</th>
                     <th scope="col">Nombre</th>
                     <th scope="col">Precio</th>
                     <th scope="col">Categoría</th>
                   </tr>
                 </thead>
                 <tbody>
                     <%for(int i=0;i<prod.size();i++ ){%>
                   <tr>
                     <th scope="row"><%=prod.get(i).getID()%></th>
                     <td><%=prod.get(i).getNombre()%></td>
                     <td><%=prod.get(i).getPrecio()%></td>
                     <td><%=prod.get(i).getCategoria()%></td>
                   </tr>
                    <%}%>
                   </tbody>
               </table> 
 <div class="row justify-content-center">
        <nav aria-label="Page navigation example">
            <ul class="pagination">
    <%    
    int pag = 1;
    //Al momento de dar siguiente o presionar otro botón, manda como parametro "pg" con el número de página.
    if (request.getParameter("pg") != null) {
        pag = Integer.valueOf(request.getParameter("pg"));
    } 
    //Elementos por página.
    int maxPag = prod.size() / 9;
    //Aquí hago una operación para obtener el número de registro del que inicia.    
    int regMin = (pag - 1) * 9;
    //Aquí hago una operación para obtener el número de registros máximos para mostrar en esa página.
    //Esto con el fin, de recorrer el arreglo desde el registro mínimo hasta el registro máximo.
    int regMax = pag * 9;
%>

<% //Pregunto si hay más de una página, para comenzar paginación.
        if (maxPag >= 1) {
        //Si la página diferente a uno, si agrega el botón anterior.
            if(pag!=1){%>
                <li class="page-item">
                    <a class="page-link" href="listadoPedidosCliente.jsp?pg=<%=pag - 1%>" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                        <span class="sr-only">Previous</span>
                    </a>
                </li>
                            
            <%}%>
            <%//Realizo el for para calcular el máximo de páginas.
                for (int i = 0; i < maxPag; i++) {
                //Si la página es igual a la página actual, muestra la etiqueta active.
                    if(i+1==pag){
            %>  
                        <li class="page-item active"><a class="page-link" href="#"><%=i+1%></a></li>
                            
                        <%  }//Si no, sigue mostrando las etiquetas normales con la opción para desplazarse.
                    else{%>
                        <li class="page-item"><a class="page-link" href="listadoPedidosCliente.jsp?pg=<%=i+1%>"><%=i+1%></a></li>
                    <%}}
                    //Sí pagina es diferente al número máximo de páginas, muestra la opción siguiente.
                    if(pag!=maxPag){%>
                        <li class="page-item">
                            <a class="page-link" href="listadoPedidosCliente.jsp?pg=<%=pag + 1%>" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                                <span class="sr-only">Next</span>
                            </a>
                        </li>
                            
                    <%}}//Si el máximo de páginas no es mayor a 1, muestra solo una página 
                    else {%>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                <%}
                %>    
            </ul>
        </nav>    
    </div>  
  <!-- /.container -->
</div>

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>

