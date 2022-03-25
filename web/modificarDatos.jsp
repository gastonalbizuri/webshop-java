<%-- 
    Document   : modificarDatos
    Created on : 24/08/2020, 21:23:31
    Author     : Usuario
--%>
<%@page import="Negocio.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession objSesion = request.getSession(false);
    Usuario usuarioActual = (Usuario) objSesion.getAttribute("userActual");
    String error = "";
    String notificacion = "";
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
 
    <%if (usuarioActual.getTipoUsuario().equals("Cliente")){ %>
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
                        <a class="nav-link" href="litadoProductos.jsp">Productos</a>
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
  <!-- Page Content -->
    <div class="container-profile">
        <div class ="row justify-content-center" >
            <form action="ModificarDatos" method="post" enctype="multipart/form-data">
                <h3 id="modif">Modificar mis datos</h3>
     
               <% if (objSesion.getAttribute("notificacionModif") != null){
                    notificacion = (String) objSesion.getAttribute("notificacionModif");%>
                <div class="alert alert-success" role="alert">
                    <label align="center"><%=notificacion%></label>
                </div>                 
                <%}%>
                <%objSesion.removeAttribute("notificacionModif");%>
                
                <%if (objSesion.getAttribute("errorModif") != null){
                    error = (String) objSesion.getAttribute("errorModif");%>
                <div id="notificacion" class="alert alert-danger" role="alert">
                    <label align="center"><%=error%></label>
                </div>
                <%}%>
                <%objSesion.removeAttribute("errorModif");%>
             
                
                
                <label for="exampleInputNombre">Nombre</label>
                <input type="text" class="form-control" id="exampleInputNombre" name="nombre" aria-describedby="nombreHelp" value="<%=usuarioActual.getNombre()%>" required><br>
                
                <label for="exampleInputApellido">Apellido</label>
                <input type="text" class="form-control" id="exampleInputApellido" name="apellido" aria-describedby="apellidoHelp" value="<%=usuarioActual.getApellido()%>" required><br>
                
                <label for="exampleInputContraseña">Contraseña Actual</label>
                <input type="password" class="form-control" id="exampleInputContraseña" name="contrasenaAct" aria-describedby="passHelp" required minlength="8" maxlength="16"><br>
                
                <label for="exampleInputContraseña">Nueva Contraseña</label>
                <input type="password" class="form-control" id="exampleInputContraseña" name="passNueva" aria-describedby="passHelp" ><br>
                
                <label for="exampleInputContraseña">Repita Nueva Contraseña</label>
                <input type="password" class="form-control" id="exampleInputContraseña" name="passNueva2" aria-describedby="passHelp"  ><br>
                
                <label for="exampleInputCorreo">Email</label>
                <input type="email" class="form-control" id="exampleInputCorreo" name="email" aria-describedby="emailHelp" value="<%=usuarioActual.getMail()%>" required><br>
                
                <label for="exampleInputTel">Teléfono</label>
                <input type="tel" class="form-control" id="exampleInputTel" name="telefono" aria-describedby="telHelp" value="<%=usuarioActual.getTelefono()%>" required pattern="[0-9]+" title="Ingrese solo números."><br>
                
                <label for="exampleInputDireccion">Dirección</label>
                <input type="text" class="form-control" id="exampleInputDireccion" name="direccion" aria-describedby="direccionHelp" value="<%=usuarioActual.getDireccion()%>" required><br>
                
                <div class="form-group" id="modificar-datos-button"> 
                    <a type="button"  class="btn btn-secondary" href="perfil.jsp">Cancelar</a>
                    <button type="submit"  class="btn btn-primary">Modificar Datos</button>
                    
                    <input type="hidden" name="usuario" value="<%=usuarioActual.getUsuario()%>">
                    <input type="hidden" name="contActualReal" value="<%=usuarioActual.getPassword()%>">
                    <input type="hidden" name="tipoUsuario" value="<%=usuarioActual.getTipoUsuario()%>">
                    <input type="hidden" name="imagen" value="<%=usuarioActual.getFoto()%>">
                </div>
                <br>
            
                    
            </form>
        </div>
    </div>
  
  <!-- /.container -->



  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
