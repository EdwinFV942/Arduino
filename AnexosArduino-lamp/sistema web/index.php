
<?php
// Código para validar si hay una sesión activa.
@$idu=$_COOKIE['idu'];
@$acceso=$_COOKIE['acceso'];
$bandera=0;
if(empty($_REQUEST['url'])) {
    $_REQUEST['url']= 'index_p';
    if ($idu == "" or $acceso == "") {
        @$msg = $_REQUEST['msg'];
        include("login.php");
        exit;
    }
}

if(@$_REQUEST['url']=="accesos"){
    $archivo = "controllers/".$_REQUEST['url'].".php";
    require($archivo);
    exit;
}
if ($idu == "" or $acceso == "") {
    @$msg = $_REQUEST['msg'];
    include("login.php");
    exit;
}
require("header.html");  // Header para la visualización de la interfaz gráfica.
// inicio del contenido de la página
    require('helpers.php');
    views($_REQUEST['url']);
// fin del contenido de la página

require("footer.html"); // footer de la interfaz gráfica.
?>
