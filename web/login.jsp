<%-- 
    Document   : login
    Created on : 02/08/2020, 20:02:55
    Author     : Usuario
--%>
<%
    HttpSession objSesion = request.getSession(false);
    String exito = "";
    String error = "";
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link rel="stylesheet" href="css/general.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    </head>
<!-- This snippet uses Font Awesome 5 Free as a dependency. You can download it at fontawesome.io! -->
<body>
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
    <div class="container-log" >
        <div class ="row" >
            <form action="Login" method="post">
                <h3>Iniciar sesión</h3>
                <% if (objSesion.getAttribute("errorLogin") != null){
                   error = (String) objSesion.getAttribute("errorLogin");%>
                    <div id="notificacion" class="alert alert-danger" role="alert">
                        <label align="center"><%=error%></label>
                    </div>
                    <%}%>
                 <%objSesion.removeAttribute("errorLogin");%> 
                 <%if (objSesion.getAttribute("exitoRegistro") != null){
                        exito = (String) objSesion.getAttribute("exitoRegistro");%>
                    <div class="alert alert-success" role="alert">
                        <label align="center"><%=exito%></label>
                    </div>                 
                <%}%>
                 <%objSesion.removeAttribute("exitoRegistro");%>
                <div class="form-group" >
                    <label for="exampleInputUsuario">Usuario</label>
                    <input type="text" class="form-control" id="exampleInputUsuario" name="usuario" aria-describedby="usuarioHelp" >
                   <!-- <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>-->
                </div>
                <div class="form-group">
                    <label for="exampleInputPassword1">Contraseña</label>
                    <input type="password" class="form-control" id="exampleInputPassword1" name="password">
                </div>
                <div class="form-group" >
                    <button type="submit" class="btn btn-primary">Iniciar sesión</button><br>
                 
                </div> 
               <div class="form-group" >
                    <label for="registro">¿Eres nuevo en Albicar? <a href="registroNuevo.jsp">Regístrate ahora</a></label>
               </div>
                    
            </form>
        </div>
    </div>
                 
   
  

  
</body>
</html>