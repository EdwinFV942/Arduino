<?php
$idu=$_COOKIE['idu'];
require ("controllers/Base64.php");
$Base64=new Base64();
include('controllers/ConectorBD.php');
$conector= new ConectorBD();
$conexion= $conector->ConectarBD();
$sql="SELECT CONCAT(u.`nombre`,' ', u.`app`, ' ', u.`apm`) AS nombre, u.`idTipoUsuario` AS tipousuario FROM usuarios AS u WHERE u.`idUsuario`=$idu;";
$consulta=$conexion->query($sql) or die("Error en consultar el nombre de usuario");
while($resultado=$consulta->fetch_assoc()){
    $nombre=utf8_decode($resultado["nombre"]);
    $tipousuario=$resultado["tipousuario"];
    $idu2=$Base64->EncodeThis("idu=".$idu);
}
$conector->DesconectarBD($conexion);
$idu2=$Base64->EncodeThis("idu=".$idu);
?>

<body>

<div id="wrapper">

    <!-- Navigation -->
    <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.php"><?php echo $nombre;?></a>
        </div>
        <!-- /.navbar-header -->

        <ul class="nav navbar-top-links navbar-right">
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="fa fa-envelope fa-fw"></i>  <i class="fa fa-caret-down"></i>
                </a>
                <ul class="dropdown-menu dropdown-messages">
                    <li>
                        <a href="#">
                            <div>
                                <strong>John Smith</strong>
                                    <span class="pull-right text-muted">
                                        <em>Yesterday</em>
                                    </span>
                            </div>
                            <div>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque eleifend...</div>
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="#">
                            <div>
                                <strong>John Smith</strong>
                                    <span class="pull-right text-muted">
                                        <em>Yesterday</em>
                                    </span>
                            </div>
                            <div>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque eleifend...</div>
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="#">
                            <div>
                                <strong>John Smith</strong>
                                    <span class="pull-right text-muted">
                                        <em>Yesterday</em>
                                    </span>
                            </div>
                            <div>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque eleifend...</div>
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a class="text-center" href="#">
                            <strong>Read All Messages</strong>
                            <i class="fa fa-angle-right"></i>
                        </a>
                    </li>
                </ul>
                <!-- /.dropdown-messages -->
            </li>
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="fa fa-bell fa-fw"></i>  <i class="fa fa-caret-down"></i>
                </a>
                <ul class="dropdown-menu dropdown-alerts">
                    <li>
                        <a href="#">
                            <div>
                                <i class="fa fa-comment fa-fw"></i> New Comment
                                <span class="pull-right text-muted small">4 minutes ago</span>
                            </div>
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="#">
                            <div>
                                <i class="fa fa-twitter fa-fw"></i> 3 New Followers
                                <span class="pull-right text-muted small">12 minutes ago</span>
                            </div>
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="#">
                            <div>
                                <i class="fa fa-envelope fa-fw"></i> Message Sent
                                <span class="pull-right text-muted small">4 minutes ago</span>
                            </div>
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="#">
                            <div>
                                <i class="fa fa-tasks fa-fw"></i> New Task
                                <span class="pull-right text-muted small">4 minutes ago</span>
                            </div>
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="#">
                            <div>
                                <i class="fa fa-upload fa-fw"></i> Server Rebooted
                                <span class="pull-right text-muted small">4 minutes ago</span>
                            </div>
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a class="text-center" href="#">
                            <strong>See All Alerts</strong>
                            <i class="fa fa-angle-right"></i>
                        </a>
                    </li>
                </ul>
                <!-- /.dropdown-alerts -->
            </li>
            <!-- /.dropdown -->
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="fa fa-user fa-fw"></i>  <i class="fa fa-caret-down"></i>
                </a>
                <ul class="dropdown-menu dropdown-user">
                    <li><a href="?url=editaPerfil&<?php echo$idu2;?>"><i class="fa fa-user fa-fw"></i> Editar Perfil</a>
                    </li>
                    <!-- <li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a>
                    </li> -->
                    <li class="divider"></li>
                    <li><a href="?url=cerrarsesion"><i class="fa fa-sign-out fa-fw"></i> Cerrar Sesión</a>
                    </li>
                </ul>
                <!-- /.dropdown-user -->
            </li>
            <!-- /.dropdown -->
        </ul>
        <!-- /.navbar-top-links -->

<!--   ****************************************************************************************************************  -->
        <div class="navbar-default sidebar" role="navigation">
            <div class="sidebar-nav navbar-collapse">
                <ul class="nav" id="side-menu">

                    <li>
                        <a href="index.php"><i class="fa fa-dashboard fa-fw"></i> Dashboard</a>
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-bolt fa-fw"></i> Energía<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a href="#"><i class="fa fa-tasks fa-fw"></i> Estadísticas de consumo</a>
                            </li>
                            <?php if($tipousuario==1){?>
                            <li>
                                <a href="#"><i class="fa fa-file-text fa-fw"></i> Reportes de consumo</a>
                            </li>
                            <?php }?>
                        </ul>
                        <!-- /.nav-second-level -->
                    </li>
                    <li>
                        <a href="#"><i class="fa  fa-sun-o fa-fw"></i> Iluminación<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a href="?url=iluminarias"><i class="fa fa-lightbulb-o fa-fw"></i> Control de iluminación</a>
                            </li>
                          <!--  " Opción para expancion del proyecto(cuando se tenga un balastro dimeable) "   <li>
                                <a href="#"><i class="fa fa-adjust fa-fw"></i> Intensidad de luz</a>
                            </li> -->
                            <?php if($tipousuario==1){?>
                            <li>
                                <a href="#"><i class="fa fa-gear fa-fw"></i> Conf. de iluminación <span class="fa arrow"></span></a>
                                <ul class="nav nav-third-level">
                                    <li>
                                        <a href="?url=microcontroladores"><i class="fa fa-retweet fa-fw"></i> Microcontroladores</a>
                                    </li>
                                    <li>
                                        <a href="#"><i class="fa fa-user fa-fw"></i><i class="fa fa-retweet fa-fw"></i> Usuarios</a>
                                    </li>
                                    <li>
                                        <a href="#"><i class="fa fa-home fa-fw"></i><i class="fa fa-retweet fa-fw"></i> Zonas</a>
                                    </li>
                                </ul>
                            </li>
                            <?php }?>

                        </ul>
                        <!-- /.nav-second-level -->
                    </li>
                    <?php if($tipousuario==1){?>
                    <li>
                        <a href="#"><i class="fa fa-building fa-fw"></i> Infraestructura<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a href="?url=edificios"><i class="fa fa-building-o fa-fw"></i> Edificios</a>
                            </li>
                            <li>
                                <a href="#"><i class="fa fa-home fa-fw"></i> Ubicaciones</a>
                            </li>
                            <li>
                                <a href="#"><i class="fa fa-columns fa-fw"></i> Zonas</a>
                            </li>
                        </ul>
                        <!-- /.nav-second-level -->
                    </li>
                    <?php } ?>
                    <!--  " Opción para expancion del proyecto, Sistemas de Intrusión "
                    <li>
                         <a href="#"><i class="fa  fa-spinner fa-fw"></i> Sensores<span class="fa arrow"></span></a>
                         <ul class="nav nav-second-level">
                             <li>
                              <a href="#"><i class="fa  fa-sun-o fa-fw"></i> Temperatura</a>
                             </li>
                             <li>
                                 <a href="#"><i class="fa fa-fire fa-fw"></i> Humo</a>
                             </li>
                             <li>
                                 <a href="#"><i class="fa fa-gears fa-fw"></i> Configuración</a>
                             </li>
                         </ul>
                     </li> -->

                     <li>
                         <a href="#"><i class="fa fa-bell-o fa-fw"></i> Alertas</a>
                     </li>
                    <?php if($tipousuario==1){?>
                        <li>
                        <li>
                            <a href="?url=camaras"><i class="fa fa-video-camera fa-fw"></i> Cámaras</a>
                        </li>
                    <?php }?>
                    <?php if($tipousuario==1){?>
                        <li>
                        <li>
                            <a href="?url=departamentos"><i class="fa fa-group fa-fw"></i> Departamentos</a>
                        </li>
                    <?php }?>
                    <?php if($tipousuario==1){?>
                    <li>
                        <a href="?url=usuarios"><i class="fa fa-user fa-fw"></i> Usuarios</a>
                    </li>
                    <?php } ?>
                    <!-- <li>
                        <a href="#"><i class="fa fa-edit fa-fw"></i> Forms</a>
                     </li>

                     <li>
                         <a href="#"><i class="fa fa-sitemap fa-fw"></i> Multi-Level Dropdown<span class="fa arrow"></span></a>
                         <ul class="nav nav-second-level">
                             <li>
                                 <a href="#">Second Level Item</a>
                             </li>
                             <li>
                                 <a href="#">Second Level Item</a>
                             </li>
                             <li>
                                 <a href="#">Third Level <span class="fa arrow"></span></a>
                                 <ul class="nav nav-third-level">
                                     <li>
                                         <a href="#">Third Level Item</a>
                                     </li>
                                     <li>
                                         <a href="#">Third Level Item</a>
                                     </li>
                                     <li>
                                         <a href="#">Third Level Item</a>
                                     </li>
                                     <li>
                                         <a href="#">Third Level Item</a>
                                     </li>
                                 </ul>
                                 <!-- /.nav-third-level
                             </li>
                         </ul>
                         <!-- /.nav-second-level
                     </li>
                     <li class="active">
                         <a href="#"><i class="fa fa-files-o fa-fw"></i> Sample Pages<span class="fa arrow"></span></a>
                         <ul class="nav nav-second-level">
                             <li>
                                 <a  href="#">Blank Page</a>
                             </li>
                             <li>
                                 <a href="#">Login Page</a>
                             </li>
                         </ul>
                         <!-- /.nav-second-level
                     </li>  -->
                </ul>
            </div>
            <!-- /.sidebar-collapse -->
        </div>
        <!-- /.navbar-static-side -->
    </nav>