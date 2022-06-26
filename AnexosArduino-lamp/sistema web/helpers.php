<?php
function views($nombre)
{
    if (empty($nombre)) {
        $nombre = "index_p";
    }

    $archivo = "views/$nombre.php";
    if (file_exists($archivo)) {
        require($archivo);
    } else {
        echo "Error acrhivo no encontrado ";
    }

}