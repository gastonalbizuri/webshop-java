<%-- 
    Document   : buscaProductoEliminar
    Created on : 21/09/2020, 21:09:32
    Author     : maiic
--%>

<%@page import="Negocio.Usuario"%>
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
    String error = "";
  
    
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
        <form action="BuscarProductosDelete" method="post">
            <h3 id="modif">Buscar Productos</h3>
            
            <label for="exampleCodigoProd">C??digo</label>
            <input type="text" class="form-control" id="exampleCodigoProd" name="codigo" aria-describedby="codigoHelp" required><br>
                
                <%if (objSesion.getAttribute("notificacion") != null){
                    notificacion = (String) objSesion.getAttribute("notificacion");%>
                    <div id="notificacion" class="alert alert-success" role="alert">
                        <label align="center"><%=notificacion%></label>
                    </div>
                <%}%>
                <%objSesion.removeAttribute("notificacion");%>
                
                <%if (objSesion.getAttribute("estado") != null){ 
                    error = (String) objSesion.getAttribute("estado");%>
                    <div id="notificacion" class="alert alert-danger" role="alert">
                        <label align="center"><%=error%></label>
                    </div>
                <%}%>
                <%objSesion.removeAttribute("estado");%>
        <div class="form-group" id="modificar-datos-button"> 
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
                     <th scope="col">C??digo</th>
                     <th scope="col">Nombre</th>
                     <th scope="col">Precio</th>
                     <th scope="col">Categor??a</th>
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
    int maxPag = prod.size() / 9;
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
  <!-- /.container -->
</div>


  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>


