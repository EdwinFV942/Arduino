<?php 
$host = "localhost";
$username = "root";
$password = "";
$database = "proyectos";

$conexion = mysqli_connect("$host", "$username", "$password", "$database");

// if ($conexion->connect_errno) {
//     # code...
//     echo "Fallo al conectarse a la base de datos: (" .mysqli->connect_errno .")" . mysqli->connect_error;
// }

// echo $mysqli-host_info. "\n";

if ($conexion) {
    # code...
    echo "La conexion fue exitosa";
}else{
    echo "La conexion no se pudo realizar";
}