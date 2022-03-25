<%@page import="Negocio.Usuario"%>
<%@page import="Datos.ConsultaProductos"%>
<%@page import="Negocio.Producto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Base64"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession objSesion = request.getSession(false);
    Usuario usuarioActual = (Usuario) objSesion.getAttribute("userActual");
    objSesion.removeAttribute("error");
    String notificacion = "";
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
  
 <!-- Page Content -->
  <div class="container">
      
    
    <div class="row">

      <div class="col-lg-3">

        <h1 class="my-4"><img class="logo" src="img/logo.png"></img></h1>
        <div class="list-group">
          <a href="#" class="list-group-item">Bebidas</a>
          <a href="#" class="list-group-item">Carnicería y pescadería</a>
          <a href="#" class="list-group-item">Fiambres y salchichas</a>
          <a href="#" class="list-group-item">Lácteos y quesos</a>
          <a href="#" class="list-group-item">Panadería y bollería industrial</a>
          <a href="#" class="list-group-item">Productos de limpieza</a>          
          <a href="#" class="list-group-item">Perfumería</a>          
        </div>

      </div>
      <!-- /.col-lg-3 -->

      <div class="col-lg-9">
        <%if (objSesion.getAttribute("notificacionCarrito") != null){
            notificacion = (String) objSesion.getAttribute("notificacionCarrito");%>
            <div id="notificacion" class="alert alert-danger" role="alert">
                <label align="center"><%=notificacion%></label>
            </div>
        <%}%>
        <%objSesion.removeAttribute("notificacionCarrito");%>

        <div id="carouselExampleIndicators" class="carousel slide my-4" data-ride="carousel">
          <ol class="carousel-indicators">
            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
          </ol>
          <div class="carousel-inner" role="listbox">
            <div class="carousel-item active">
              <img class="d-block img-fluid" src="img/carrousel1.jpg" alt="First slide">
            </div>
            <div class="carousel-item">
              <img class="d-block img-fluid" src="img/carrousel2.jpg" alt="Second slide">
            </div>
            
          </div>
          <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
          </a>
          <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
          </a>
        </div>
        
        <div class="row">
         
          <div class="col-lg-4 col-md-6 mb-4">
            <div class="card h-100">
                <a href="#"><img class="card-img-top" src="img/Bebidas/LataQuilmes.jpg" alt=""></a>
                <div class="card-body">
                    <small><font color="red">Oferta publicada</font></small>  
                    <h4 class="card-title">
                    <a href="#">Cerveza Quilmes</a>
                    </h4>
                    <h5>$52.00</h5>
                    <p class="card-text">Cerveza Quilmes En Lata X 473 Cc.</p>
                </div>
                <div class="card-footer">
                    <h6>Si desea eliminar o modificar este producto, ingresar <a href="productosABM.jsp">aquí</a></h6> 
                </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 mb-4">
            <div class="card h-100">
                <a href="#"><img class="card-img-top" src="img/LacteosQuesos/quesoPauli.jpg" alt=""></a>
                <div class="card-body">
                    <small><font color="red">Oferta publicada</font></small> 
                    <h4 class="card-title">
                    <a href="#">Queso La Paulina</a>
                    </h4>
                    <h5>$34.71</h5>
                    <p class="card-text">Queso Cremoso La Paulina X100gr.</p>
                </div>
                <div class="card-footer">
                    <form action="AgregarProducto" method="post">
                        <h6>Si desea eliminar o modificar este producto, ingresar <a href="productosABM.jsp">aquí</a></h6>
                    </form> 
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 mb-4">
            <div class="card h-100">
              <a href="#"><img class="card-img-top" src="img/frutaverdu/pera.jpg" alt=""></a>
              <div class="card-body">
                  <small><font color="red">Oferta publicada</font></small> 
                <h4 class="card-title">
                  <a href="#">Pera</a>
                </h4>
                <h5>$9.99</h5>
                <p class="card-text">Pera X 100 Gr.</p>
              </div>
              <div class="card-footer">
                <form action="AgregarProducto" method="post">
                    <h6>Si desea eliminar o modificar este producto, ingresar <a href="productosABM.jsp">aquí</a></h6>
                </form> 
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 mb-4">
            <div class="card h-100">
              <a href="#"><img class="card-img-top" src="img/carnes/lomo.jpg" alt=""></a>
              <div class="card-body">
                  <small><font color="red">Oferta publicada</font></small> 
                <h4 class="card-title">
                  <a href="#">Cabeza de Lomo</a>
                </h4>
                <h5>$41.90</h5>
                <p class="card-text">Cabeza De Lomo Ternera X 100 Gr.</p>
              </div>
              <div class="card-footer">
                <form action="AgregarProducto" method="post">
                    <h6>Si desea eliminar o modificar este producto, ingresar <a href="productosABM.jsp">aquí</a></h6>
                </form> 
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 mb-4">
            <div class="card h-100">
              <a href="#"><img class="card-img-top" src="img/panes/panFargo.jpg" alt=""></a>
              <div class="card-body">
                  <small><font color="red">Oferta publicada</font></small> 
                <h4 class="card-title">
                  <a href="#">Pan de hamb. Fargo</a>
                </h4>
                <h5>$96,72</h5>
                <p class="card-text">Pan De Hamburguesa Fargo C/Semillas Sesamo X4u.</p>
              </div>
              <div class="card-footer">
                <form action="AgregarProducto" method="post">
                    <h6>Si desea eliminar o modificar este producto, ingresar <a href="productosABM.jsp">aquí</a></h6>
                </form> 
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 mb-4">
            <div class="card h-100">
              <a href="#"><img class="card-img-top" src="img/limpieza/lavandina.jpg" alt=""></a>
              <div class="card-body">
                  <small><font color="red">Oferta publicada</font></small> 
                <h4 class="card-title">
                  <a href="#">Lavandina Ayudín</a>
                </h4>
                <h5>$78.99</h5>
                <p class="card-text">Lavandina En Gel Ayudin X700ml. Menta</p>
              </div>
              <div class="card-footer">
                <form action="AgregarProducto" method="post">
                    <h6>Si desea eliminar o modificar este producto, ingresar <a href="productosABM.jsp">aquí</a></h6>
                </form> 
              </div>
            </div>
          </div>

        </div>
        <!-- /.row -->
        
      </div>
      <!-- /.col-lg-9 -->

    </div>
    <!-- /.row -->
    
  </div>
  <!-- /.container -->
        
          
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
  <div class="container">
      
    
    <div class="row">

      <div class="col-lg-3">

        <h1 class="my-4"><img class="logo" src="img/logo.png"></img></h1>
        <div class="list-group">
          <a href="bebidas.jsp" class="list-group-item">Bebidas</a>
          <a href="carnes.jsp" class="list-group-item">Carnicería y pescadería</a>
          <a href="fiambres.jsp" class="list-group-item">Fiambres y salchichas</a>
          <a href="lacteos.jsp" class="list-group-item">Lácteos y quesos</a>
          <a href="panaderia.jsp" class="list-group-item">Panadería y bollería industrial</a>
          <a href="limpieza.jsp" class="list-group-item">Productos de limpieza</a>          
          <a href="perfumeria.jsp" class="list-group-item">Perfumería</a>          
        </div>

      </div>
      <!-- /.col-lg-3 -->

      <div class="col-lg-9">

        <div id="carouselExampleIndicators" class="carousel slide my-4" data-ride="carousel">
          <ol class="carousel-indicators">
            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
          </ol>
          <div class="carousel-inner" role="listbox">
            <div class="carousel-item active">
              <img class="d-block img-fluid" src="img/carrousel1.jpg" alt="First slide">
            </div>
            <div class="carousel-item">
              <img class="d-block img-fluid" src="img/carrousel2.jpg" alt="Second slide">
            </div>
            
          </div>
          <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
          </a>
          <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
          </a>
        </div>
        
        <div class="row">
         
          <div class="col-lg-4 col-md-6 mb-4">
            <div class="card h-100">
                <a href="listadoProductos.jsp"><img class="card-img-top" src="img/Bebidas/LataQuilmes.jpg" alt=""></a>
                <div class="card-body">
                    <small><font color="red">Oferta publicada</font></small>  
                    <h4 class="card-title">
                    <a href="listadoProductos.jsp">Cerveza Quilmes</a>
                    </h4>
                    <h5>$52.00</h5>
                    <p class="card-text">Cerveza Quilmes En Lata X 473 Cc.</p>
                </div>
                <div class="card-footer">
                   <small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9733;</small>
                </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 mb-4">
            <div class="card h-100">
                <a href="listadoProductos.jsp"><img class="card-img-top" src="img/LacteosQuesos/quesoPauli.jpg" alt=""></a>
                <div class="card-body">
                    <small><font color="red">Oferta publicada</font></small> 
                    <h4 class="card-title">
                    <a href="listadoProductos.jsp">Queso La Paulina</a>
                    </h4>
                    <h5>$34.71</h5>
                    <p class="card-text">Queso Cremoso La Paulina X100gr.</p>
                </div>
                <div class="card-footer">
                    <small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9734;</small>
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 mb-4">
            <div class="card h-100">
              <a href="listadoProductos.jsp"><img class="card-img-top" src="img/frutaverdu/pera.jpg" alt=""></a>
              <div class="card-body">
                  <small><font color="red">Oferta publicada</font></small> 
                <h4 class="card-title">
                  <a href="listadoProductos.jsp">Pera</a>
                </h4>
                <h5>$9.99</h5>
                <p class="card-text">Pera X 100 Gr.</p>
              </div>
              <div class="card-footer">
                <small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9734;</small>
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 mb-4">
            <div class="card h-100">
              <a href="listadoProductos.jsp"><img class="card-img-top" src="img/carnes/lomo.jpg" alt=""></a>
              <div class="card-body">
                  <small><font color="red">Oferta publicada</font></small> 
                <h4 class="card-title">
                  <a href="listadoProductos.jsp">Cabeza de Lomo</a>
                </h4>
                <h5>$41.90</h5>
                <p class="card-text">Cabeza De Lomo Ternera X 100 Gr.</p>
              </div>
              <div class="card-footer">
                <form action="AgregarProducto" method="post">
                   <small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9734;</small>
                </form> 
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 mb-4">
            <div class="card h-100">
              <a href="listadoProductos.jsp"><img class="card-img-top" src="img/panes/panFargo.jpg" alt=""></a>
              <div class="card-body">
                  <small><font color="red">Oferta publicada</font></small> 
                <h4 class="card-title">
                  <a href="listadoProductos.jsp">Pan de hamb. Fargo</a>
                </h4>
                <h5>$96,72</h5>
                <p class="card-text">Pan De Hamburguesa Fargo C/Semillas Sesamo X4u.</p>
              </div>
              <div class="card-footer">
                <small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9733;</small>
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 mb-4">
            <div class="card h-100">
              <a href="listadoProductos.jsp"><img class="card-img-top" src="img/limpieza/lavandina.jpg" alt=""></a>
              <div class="card-body">
                  <small><font color="red">Oferta publicada</font></small> 
                <h4 class="card-title">
                  <a href="listadoProductos.jsp">Lavandina Ayudín</a>
                </h4>
                <h5>$78.99</h5>
                <p class="card-text">Lavandina En Gel Ayudin X700ml. Menta</p>
              </div>
              <div class="card-footer">
                <form action="AgregarProducto" method="post">
                    <small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9734;</small>
                </form> 
              </div>
            </div>
          </div>
           
        </div>
        <!-- /.row -->
        <div class="row justify-content-center">
            <a type="submit" href="listadoProductos.jsp" id="button-index" class="btn btn-primary btn-lg">Ver más</a>
        </div>
      </div>
      <!-- /.col-lg-9 -->

    </div>
    <!-- /.row -->
    
  </div>
  <!-- /.container -->
        
          
          
 <%}%> 
  
  

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>