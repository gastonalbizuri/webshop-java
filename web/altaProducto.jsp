<%-- 
    Document   : registroNuevo
    Created on : 05-ago-2020, 14:59:25
    Author     : Diana
--%>
<%@page import="Negocio.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession objSesion = request.getSession(false);
    Usuario usuarioActual = (Usuario) objSesion.getAttribute("userActual");
    
    String error = "";
%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alta Producto</title>
        <link rel="stylesheet" href="css/general.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    </head>
<!-- This snippet uses Font Awesome 5 Free as a dependency. You can download it at fontawesome.io! -->
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
    <div class="container-profile" >
        <br><br>
        <a type="submit" class="btn btn-secondary" id="seguir-comprando" href="productosABM.jsp">??? Volver</a>
        <div id="altaproduc" class="row justify-content-center">
            <h3>Alta de Productos</h3>
                
                <%if (objSesion.getAttribute("errorAltaProd") != null){
                    error = (String) objSesion.getAttribute("errorAltaProd");%>
                <div id="notificacion" class="alert alert-danger" role="alert">
                    <label align="center"><%=error%></label>
                </div>
                <%}%>
                <%objSesion.removeAttribute("errorAltaProd");%>
        </div>
        <div class ="row justify-content-center" >
            <div class="col-lg-3">
            
                <form action="AltaProducto" method="post" enctype="multipart/form-data">
                
                    <div class="form-group">
                        
                        <label for="exampleCodigoProducto">C??digo producto</label>
                        <input type="text" class="form-control" id="exampleCodigoProducto" name="codigoProducto" aria-describedby="codigoHelp" placeholder="C??digo producto" required><br>
                            
                        <label for="exampleNombreProducto">T??tulo producto</label>
                        <input type="text" class="form-control" id="exampleNombreProducto" name="nombreProducto" aria-describedby="nombreHelp" placeholder="Nombre producto" required><br>
                        
                        <label for="exampleDescripcion">Descripci??n</label>
                        <input type="text" class="form-control" id="exampleDescripcion" name="descripcion" aria-describedby="descripcionHelp" placeholder="Descripci??n" required><br>
                        
                        <label for="examplePrecioProducto">Precio</label>
                        <input type="text" class="form-control" id="examplePrecioProducto" name="precioProducto" aria-describedby="precioHelp" placeholder="Precio producto" required><br>
                        
                        <label for="exampleCategoria">Categor??a</label><br>
                        <select name="categoria">
                            <option value="0">Elige una categor??a</option>
                            <option value="Bebidas">Bebidas</option>
                            <option value="Carniceria y pescaderia">Carnicer??a y pescader??a</option>
                            <option value="Fiambres y salchichas">Fiambres y salchichas</option>
                            <option value="Lacteos y quesos">L??cteos y quesos</option>
                            <option value="Panaderia bolleria industrial">Panader??a boller??a industrial</option>
                            <option value="Productos de limpieza">Productos de limpieza</option>
                            <option value="Perfumeria">Perfumer??a</option>
                        </select><br><br>
                        
                        
                        <label for="exampleImagen">Elija una imagen</label>
                        <input type="file" class="form-control" id="exampleImagen" name="imagen"></input>
                        
                        <br>
                        
         
                        <div class="form-group" >
                            <button type="submit" class="btn btn-primary">Agregar producto</button>
                        </div> 
                            
                    </div>
                          
                                
                </form>
            </div>
        </div>
    </div>


  
</body>
</html>
      
              

              
         