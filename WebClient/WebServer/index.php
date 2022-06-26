<?php 
date_default_timezone_set('America/Mexico_City');
$conexion = mysqli_connect("localhost","root","","arduino");

if ($conexion) {
    echo "La conexion a la base de datos fue existosa";
}else {
    echo "La conexion a la base de datos no fue existosa";
}

$fotocelda = $_GET["fotocelda"];
$temperatura = $_GET["temp"];
$datetime = date("Y-m-d H:i:s");

$CONSUMOLUZ = $fotocelda * 2.976;

$insertar = "INSERT INTO sensores (id, Temperatura, cosumoLuz, DateTime) VALUES (NULL,'$temperatura','$CONSUMOLUZ','$datetime')";

$resultado = mysqli_query($conexion, $insertar);

if(!$resultado){
    echo "Error al registrar";
}else {
    echo "Datos guardados satisfactoriamente";
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.5/dist/umd/popper.min.js" integrity="sha384-Xe+8cL9oJa6tN/veChSP7q+mnSPaj5Bcu9mPX5F5xIGE0DVittaqT5lorf0EI7Vk" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-kjU+l4N0Yf4ZOJErLsIcvOU2qSb74wXpOhqTvwVx3OElZRweTnQ6d31fXEoRD1Jy" crossorigin="anonymous"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <title>Panel Administrativo</title>
</head>
<body>
    <h1>Bienvenido al Panel de Administracion</h1>
</body>
</html>