/*
SQLyog Ultimate v11.42 (64 bit)
MySQL - 10.1.9-MariaDB : Database - saidse
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`saidse` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `saidse`;

/*Table structure for table `actividades` */

DROP TABLE IF EXISTS `actividades`;

CREATE TABLE `actividades` (
  `idActividad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idActividad`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `actividades` */

insert  into `actividades`(`idActividad`,`nombre`) values (1,'Encender Luz'),(2,'Apagar Luz'),(3,'Desactivar PRI'),(4,'Activar PIR');

/*Table structure for table `alertas` */

DROP TABLE IF EXISTS `alertas`;

CREATE TABLE `alertas` (
  `idAlerta` int(11) NOT NULL AUTO_INCREMENT,
  `fechaRegistrada` datetime DEFAULT NULL,
  `Descripcion` varchar(200) DEFAULT NULL,
  `idPrioridad` int(11) DEFAULT NULL,
  `idEstatus` int(11) DEFAULT NULL,
  PRIMARY KEY (`idAlerta`),
  KEY `alertas-prioridad_idx` (`idPrioridad`),
  KEY `alertas-estatus_idx` (`idEstatus`),
  CONSTRAINT `alertas-estatus` FOREIGN KEY (`idEstatus`) REFERENCES `estatus` (`idEstatus`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `alertas-prioridad` FOREIGN KEY (`idPrioridad`) REFERENCES `prioridad` (`idPrioridad`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `alertas` */

/*Table structure for table `departamentos` */

DROP TABLE IF EXISTS `departamentos`;

CREATE TABLE `departamentos` (
  `idDepartamento` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `idEstatus` int(11) DEFAULT NULL,
  PRIMARY KEY (`idDepartamento`),
  KEY `depa_esatus_indx` (`idEstatus`),
  CONSTRAINT `depa-estatus` FOREIGN KEY (`idEstatus`) REFERENCES `estatus` (`idEstatus`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `departamentos` */

insert  into `departamentos`(`idDepartamento`,`nombre`,`idEstatus`) values (1,'DirecciÃƒÂ³n de CapacitaciÃƒÂ³n y Transferencia TecnolÃƒÂ³gÃƒÂ­ca',1),(4,'Aulas',NULL);

/*Table structure for table `edificios` */

DROP TABLE IF EXISTS `edificios`;

CREATE TABLE `edificios` (
  `idEdificio` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `idEstatus` int(11) DEFAULT NULL,
  `piso` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idEdificio`),
  KEY `estatus-edificios_indx` (`idEstatus`),
  CONSTRAINT `edificios_estatus` FOREIGN KEY (`idEstatus`) REFERENCES `estatus` (`idEstatus`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `edificios` */

insert  into `edificios`(`idEdificio`,`nombre`,`idEstatus`,`piso`) values (1,'Laboratorios ',1,'Piso 1');

/*Table structure for table `estadoiluminacion` */

DROP TABLE IF EXISTS `estadoiluminacion`;

CREATE TABLE `estadoiluminacion` (
  `idEstadoIluminacion` int(11) NOT NULL AUTO_INCREMENT,
  `Estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idEstadoIluminacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `estadoiluminacion` */

/*Table structure for table `estatus` */

DROP TABLE IF EXISTS `estatus`;

CREATE TABLE `estatus` (
  `idEstatus` int(11) NOT NULL AUTO_INCREMENT,
  `estatus` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idEstatus`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `estatus` */

insert  into `estatus`(`idEstatus`,`estatus`) values (1,'Activo'),(2,'Inactivo'),(3,'Suspendido'),(4,'Mantenimiento'),(5,'Pendiente'),(6,'Solucionado'),(7,'Critico'),(8,'Desactivado'),(9,'Retirado'),(10,'Baja');

/*Table structure for table `estatususuarios` */

DROP TABLE IF EXISTS `estatususuarios`;

CREATE TABLE `estatususuarios` (
  `idEstatusUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `estatus` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idEstatusUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `estatususuarios` */

insert  into `estatususuarios`(`idEstatusUsuario`,`estatus`) values (1,'Activo'),(2,'Suspendido'),(3,'Desactivado');

/*Table structure for table `intensidadluz` */

DROP TABLE IF EXISTS `intensidadluz`;

CREATE TABLE `intensidadluz` (
  `idIntensidadLuz` int(11) NOT NULL AUTO_INCREMENT,
  `lux` varchar(45) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `idSI` int(11) DEFAULT NULL,
  PRIMARY KEY (`idIntensidadLuz`),
  KEY `IL-SI_idx` (`idSI`),
  CONSTRAINT `IL-SI` FOREIGN KEY (`idSI`) REFERENCES `sistemaintegral` (`idSI`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `intensidadluz` */

/*Table structure for table `mantenimientos` */

DROP TABLE IF EXISTS `mantenimientos`;

CREATE TABLE `mantenimientos` (
  `idMant` int(11) NOT NULL AUTO_INCREMENT,
  `idSI` int(11) DEFAULT NULL,
  `fechaProgramada` date DEFAULT NULL,
  `fechaRealizada` date DEFAULT NULL,
  `idActividad` int(11) DEFAULT NULL,
  `idEstatus` int(11) DEFAULT NULL,
  `comentarios` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idMant`),
  KEY `mi-si_idx` (`idSI`),
  KEY `mi-estatus_idx` (`idEstatus`),
  KEY `mant-actividad_idx` (`idActividad`),
  CONSTRAINT `mant-actividad` FOREIGN KEY (`idActividad`) REFERENCES `actividades` (`idActividad`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mant-estatus` FOREIGN KEY (`idEstatus`) REFERENCES `estatus` (`idEstatus`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mant-si` FOREIGN KEY (`idSI`) REFERENCES `sistemaintegral` (`idSI`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mantenimientos` */

/*Table structure for table `marca` */

DROP TABLE IF EXISTS `marca`;

CREATE TABLE `marca` (
  `idMarca` int(11) NOT NULL AUTO_INCREMENT,
  `Marca` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idMarca`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `marca` */

insert  into `marca`(`idMarca`,`Marca`) values (1,'Arduino'),(2,'Microchip Technology'),(3,'Raspberry Pi'),(4,'Bticino'),(5,'Legrant'),(6,'hola'),(7,'mundo'),(8,'como estas'),(9,'jajaja'),(10,'Intel'),(11,'Intel2'),(12,'arduino');

/*Table structure for table `microcontrolador` */

DROP TABLE IF EXISTS `microcontrolador`;

CREATE TABLE `microcontrolador` (
  `idMicrocontrolador` int(11) NOT NULL AUTO_INCREMENT,
  `idModelo` int(11) DEFAULT NULL,
  `IP` varchar(15) DEFAULT NULL,
  `MAC` varchar(25) DEFAULT NULL,
  `idEstatus` int(11) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idMicrocontrolador`),
  KEY `arduino-modelo_idx` (`idModelo`),
  KEY `arduino-estatus_idx` (`idEstatus`),
  CONSTRAINT `microcontrolador-estatus` FOREIGN KEY (`idEstatus`) REFERENCES `estatus` (`idEstatus`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `microcontrolador-modelo` FOREIGN KEY (`idModelo`) REFERENCES `modelos` (`idModelo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `microcontrolador` */

insert  into `microcontrolador`(`idMicrocontrolador`,`idModelo`,`IP`,`MAC`,`idEstatus`,`nombre`) values (1,4,'192.168.214.5','DE:AD:BE:EF:FE:ED',1,'Microcontrolador del laboratorio de seguridad electrÃƒÂ³nica y CCTV');

/*Table structure for table `modelos` */

DROP TABLE IF EXISTS `modelos`;

CREATE TABLE `modelos` (
  `idModelo` int(11) NOT NULL AUTO_INCREMENT,
  `modelo` varchar(45) DEFAULT NULL,
  `idMarca` int(11) DEFAULT NULL,
  PRIMARY KEY (`idModelo`),
  KEY `modelo-marca_idx` (`idMarca`),
  CONSTRAINT `modelo-marca` FOREIGN KEY (`idMarca`) REFERENCES `marca` (`idMarca`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `modelos` */

insert  into `modelos`(`idModelo`,`modelo`,`idMarca`) values (1,'UNO R3',1),(2,'K-940',2),(3,'HR911105A 15/10',3),(4,'Mega 2560 Rev3',1),(5,'Leonardo',1),(6,'BUS',4),(7,'bien y tu?',8),(8,'i3',11),(9,'Atom',10);

/*Table structure for table `prioridad` */

DROP TABLE IF EXISTS `prioridad`;

CREATE TABLE `prioridad` (
  `idPrioridad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idPrioridad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `prioridad` */

/*Table structure for table `registroiluminacion` */

DROP TABLE IF EXISTS `registroiluminacion`;

CREATE TABLE `registroiluminacion` (
  `idRI` int(11) NOT NULL AUTO_INCREMENT,
  `idSI` int(11) DEFAULT NULL,
  `idEstadoIluminacion` int(11) DEFAULT NULL,
  `fechaRegistrada` datetime DEFAULT NULL,
  PRIMARY KEY (`idRI`),
  KEY `ri-si_idx` (`idSI`),
  KEY `ri-ei_idx` (`idEstadoIluminacion`),
  CONSTRAINT `ra-si` FOREIGN KEY (`idSI`) REFERENCES `sistemaintegral` (`idSI`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ri-ei` FOREIGN KEY (`idEstadoIluminacion`) REFERENCES `estadoiluminacion` (`idEstadoIluminacion`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `registroiluminacion` */

/*Table structure for table `registroincidentes` */

DROP TABLE IF EXISTS `registroincidentes`;

CREATE TABLE `registroincidentes` (
  `idRI` int(11) NOT NULL AUTO_INCREMENT,
  `idSI` int(11) DEFAULT NULL,
  `fechaRegistrada` datetime DEFAULT NULL,
  `idPrioridad` int(11) DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idRI`),
  KEY `ri-si_idx` (`idSI`),
  KEY `ri-prioridas_idx` (`idPrioridad`),
  CONSTRAINT `ri-prioridad` FOREIGN KEY (`idPrioridad`) REFERENCES `prioridad` (`idPrioridad`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ri-si` FOREIGN KEY (`idSI`) REFERENCES `sistemaintegral` (`idSI`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `registroincidentes` */

/*Table structure for table `sistemaintegral` */

DROP TABLE IF EXISTS `sistemaintegral`;

CREATE TABLE `sistemaintegral` (
  `idSI` int(11) NOT NULL AUTO_INCREMENT,
  `idMicrocontrolador` int(11) DEFAULT NULL,
  `fechaInstalacion` date DEFAULT NULL,
  `idZona` int(11) DEFAULT NULL,
  `ZonaMicroC` int(11) DEFAULT NULL,
  PRIMARY KEY (`idSI`),
  KEY `si-arduino_idx` (`idMicrocontrolador`),
  KEY `si-zonas_idx` (`idZona`),
  CONSTRAINT `si-microcontrolador` FOREIGN KEY (`idMicrocontrolador`) REFERENCES `microcontrolador` (`idMicrocontrolador`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `si-zonas` FOREIGN KEY (`idZona`) REFERENCES `zonas` (`idZona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `sistemaintegral` */

insert  into `sistemaintegral`(`idSI`,`idMicrocontrolador`,`fechaInstalacion`,`idZona`,`ZonaMicroC`) values (1,1,'2016-03-31',1,1),(2,1,'2016-03-31',2,2);

/*Table structure for table `tipousuarios` */

DROP TABLE IF EXISTS `tipousuarios`;

CREATE TABLE `tipousuarios` (
  `idTipoUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `tipoUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTipoUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `tipousuarios` */

insert  into `tipousuarios`(`idTipoUsuario`,`tipoUsuario`) values (1,'Administrador'),(2,'Operador');

/*Table structure for table `ubicacion` */

DROP TABLE IF EXISTS `ubicacion`;

CREATE TABLE `ubicacion` (
  `idUbicacion` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `idEdificio` int(11) DEFAULT NULL,
  `idDepartamento` int(11) DEFAULT NULL,
  `piso` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idUbicacion`),
  KEY `ubicacion-edificio_idx` (`idEdificio`),
  KEY `ubicacion-depatamento_idx` (`idDepartamento`),
  CONSTRAINT `ubicacion-depatamento` FOREIGN KEY (`idDepartamento`) REFERENCES `departamentos` (`idDepartamento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ubicacion-edificio` FOREIGN KEY (`idEdificio`) REFERENCES `edificios` (`idEdificio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `ubicacion` */

insert  into `ubicacion`(`idUbicacion`,`nombre`,`idEdificio`,`idDepartamento`,`piso`) values (1,'Laboratorio de Seguridad Electrónica y CCTV',1,1,'1');

/*Table structure for table `usuarios` */

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `app` varchar(45) DEFAULT NULL,
  `apm` varchar(45) DEFAULT NULL,
  `correo` varchar(45) DEFAULT NULL,
  `contrasena` varchar(200) DEFAULT NULL,
  `idDepartamento` int(11) DEFAULT NULL,
  `idTipoUsuario` int(11) DEFAULT NULL,
  `idEstatusUsuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`),
  KEY `usuarios-departamentos_idx` (`idDepartamento`),
  KEY `usuarios-tipousuario_idx` (`idTipoUsuario`),
  KEY `usuarios-estatususuarios_idx` (`idEstatusUsuario`),
  CONSTRAINT `usuarios-departamentos` FOREIGN KEY (`idDepartamento`) REFERENCES `departamentos` (`idDepartamento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `usuarios-estatususuarios` FOREIGN KEY (`idEstatusUsuario`) REFERENCES `estatususuarios` (`idEstatusUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `usuarios-tipousuario` FOREIGN KEY (`idTipoUsuario`) REFERENCES `tipousuarios` (`idTipoUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `usuarios` */

insert  into `usuarios`(`idUsuario`,`nombre`,`app`,`apm`,`correo`,`contrasena`,`idDepartamento`,`idTipoUsuario`,`idEstatusUsuario`) values (1,'Cruz Alfredo','Bibiano','MontaÃƒÂ±o','cbibiano@inictel-uni.edu.pe','d8578edf8458ce06fbc5bb76a58c5ca4',1,2,1),(2,'Administrador','','','admin','21232f297a57a5a743894a0e4a801fc3',1,1,1);

/*Table structure for table `usuarios_si` */

DROP TABLE IF EXISTS `usuarios_si`;

CREATE TABLE `usuarios_si` (
  `idUsuarios_SI` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) DEFAULT NULL,
  `idSI` int(11) DEFAULT NULL,
  PRIMARY KEY (`idUsuarios_SI`),
  KEY `u_si-usuarios_idx` (`idUsuario`),
  KEY `u_si-si_idx` (`idSI`),
  CONSTRAINT `u_si-si` FOREIGN KEY (`idSI`) REFERENCES `sistemaintegral` (`idSI`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `u_si-usuarios` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `usuarios_si` */

insert  into `usuarios_si`(`idUsuarios_SI`,`idUsuario`,`idSI`) values (1,1,1),(2,1,2),(3,2,1),(4,2,2);

/*Table structure for table `zonas` */

DROP TABLE IF EXISTS `zonas`;

CREATE TABLE `zonas` (
  `idZona` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `idUbicacion` int(11) DEFAULT NULL,
  PRIMARY KEY (`idZona`),
  KEY `zonas-ubicaciones_idx` (`idUbicacion`),
  CONSTRAINT `zonas-ubicaciones` FOREIGN KEY (`idUbicacion`) REFERENCES `ubicacion` (`idUbicacion`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `zonas` */

insert  into `zonas`(`idZona`,`nombre`,`idUbicacion`) values (1,'zona A',1),(2,'zona B',1);

/* Function  structure for function  `altaDepartamento` */

/*!50003 DROP FUNCTION IF EXISTS `altaDepartamento` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `altaDepartamento`( _nombre VARCHAR(100)) RETURNS int(11)
BEGIN
INSERT INTO departamentos(nombre,idEstatus) VALUES(_nombre,1);
return 1;
END */$$
DELIMITER ;

/* Function  structure for function  `altaEdificio` */

/*!50003 DROP FUNCTION IF EXISTS `altaEdificio` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `altaEdificio`( _nombre VARCHAR(100),_piso VARCHAR(50)) RETURNS int(11)
BEGIN
INSERT INTO edificios(nombre,piso,idEstatus) VALUES(_nombre,_piso,1);
RETURN 1;
END */$$
DELIMITER ;

/* Function  structure for function  `altaMarca` */

/*!50003 DROP FUNCTION IF EXISTS `altaMarca` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `altaMarca`( _marca VARCHAR(45) ) RETURNS int(11)
BEGIN
INSERT INTO marca(marca) 
VALUES(_marca);
RETURN 1;
END */$$
DELIMITER ;

/* Function  structure for function  `altaMicrocontrolador` */

/*!50003 DROP FUNCTION IF EXISTS `altaMicrocontrolador` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `altaMicrocontrolador`( _idModelo INT, _ip VARCHAR(45), _mac VARCHAR(45) , _nombre VARCHAR(100)) RETURNS int(11)
BEGIN
INSERT INTO microcontrolador(`idModelo`,`ip`,`mac`,`idEstatus`,`nombre`) 
VALUES(_idModelo,_ip,_mac,1,_nombre);
RETURN 1;
END */$$
DELIMITER ;

/* Function  structure for function  `altaModelo` */

/*!50003 DROP FUNCTION IF EXISTS `altaModelo` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `altaModelo`( _modelo VARCHAR(100), _idm INT ) RETURNS int(11)
BEGIN
INSERT INTO modelos(modelo,idMarca) 
VALUES(_modelo, _idm);
RETURN 1;
END */$$
DELIMITER ;

/* Function  structure for function  `altaUsuario` */

/*!50003 DROP FUNCTION IF EXISTS `altaUsuario` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `altaUsuario`( nombre varchar(45), app varchar(45), apm VARCHAR(45), 
usuario VARCHAR(45), contrasena VARCHAR(100), departamento int, tipoUsuario int ) RETURNS int(11)
begin
Insert into usuarios(nombre, app, apm, correo, contrasena, idDepartamento, idTipoUsuario, idEstatusUsuario) 
values(nombre,app,apm,usuario,contrasena,departamento,tipoUsuario,1);
RETURN 1;
END */$$
DELIMITER ;

/* Function  structure for function  `cambiaContrasena` */

/*!50003 DROP FUNCTION IF EXISTS `cambiaContrasena` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `cambiaContrasena`( _idu INT,_contrasena varchar (200)) RETURNS int(11)
begin
update usuarios set contrasena=_contrasena where idUsuario=_idu;
return 1;
end */$$
DELIMITER ;

/* Function  structure for function  `cambiaEstatusDepartamento` */

/*!50003 DROP FUNCTION IF EXISTS `cambiaEstatusDepartamento` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `cambiaEstatusDepartamento`( _idD INT,_estatus INT) RETURNS int(11)
BEGIN
UPDATE departamentos AS d  SET d.`idEstatus`=_estatus WHERE d.`idDepartamento`=_idD;	
RETURN 1;
END */$$
DELIMITER ;

/* Function  structure for function  `cambiaEstatusEdificio` */

/*!50003 DROP FUNCTION IF EXISTS `cambiaEstatusEdificio` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `cambiaEstatusEdificio`( _idE INT,_estatus INT) RETURNS int(11)
BEGIN
UPDATE edificios AS e  SET e.`idEstatus`=_estatus WHERE e.`idEdificio`=_idE;	
RETURN 1;
END */$$
DELIMITER ;

/* Function  structure for function  `cambiaEstatusMicrocontrolador` */

/*!50003 DROP FUNCTION IF EXISTS `cambiaEstatusMicrocontrolador` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `cambiaEstatusMicrocontrolador`( _idm INT,_estatus INT) RETURNS int(11)
BEGIN
UPDATE microcontrolador AS m SET m.`idEstatus`=_estatus WHERE m.`idMicrocontrolador`=_idm;	
RETURN 1;
END */$$
DELIMITER ;

/* Function  structure for function  `cambiaEstatusUsuario` */

/*!50003 DROP FUNCTION IF EXISTS `cambiaEstatusUsuario` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `cambiaEstatusUsuario`( _idu INT,_estatus INT) RETURNS int(11)
BEGIN
UPDATE usuarios SET idEstatusUsuario=_estatus WHERE idUsuario=_idu;
RETURN 1;
END */$$
DELIMITER ;

/* Function  structure for function  `editaPerfil` */

/*!50003 DROP FUNCTION IF EXISTS `editaPerfil` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `editaPerfil`( _idu int ,_nombre VARCHAR(45), _app VARCHAR(45), _apm VARCHAR(45), 
_usuario VARCHAR(45) ) RETURNS int(11)
begin
UPDATE usuarios AS u SET u.`nombre`=_nombre ,u.`app`=_app, u.`apm`=_apm, u.`correo`=_usuario 
WHERE u.`idUsuario`=_idu ;
RETURN 1;
END */$$
DELIMITER ;

/* Function  structure for function  `eliminaDepartamento` */

/*!50003 DROP FUNCTION IF EXISTS `eliminaDepartamento` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `eliminaDepartamento`( _idD INT) RETURNS int(11)
BEGIN
DELETE FROM departamentos WHERE idDepartamento=_idD;
RETURN 1;
END */$$
DELIMITER ;

/* Function  structure for function  `eliminaEdificio` */

/*!50003 DROP FUNCTION IF EXISTS `eliminaEdificio` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `eliminaEdificio`( _idE INT) RETURNS int(11)
BEGIN
DELETE FROM edificios WHERE idEdificio=_idE;
RETURN 1;
END */$$
DELIMITER ;

/* Function  structure for function  `eliminaMicrocontrolador` */

/*!50003 DROP FUNCTION IF EXISTS `eliminaMicrocontrolador` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `eliminaMicrocontrolador`( _idm INT) RETURNS int(11)
BEGIN
DELETE FROM microcontrolador WHERE idMicrocontrolador=_idm;
RETURN 1;
END */$$
DELIMITER ;

/* Function  structure for function  `eliminaUsuario` */

/*!50003 DROP FUNCTION IF EXISTS `eliminaUsuario` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `eliminaUsuario`( _idu INT) RETURNS int(11)
BEGIN
DELETE FROM usuarios WHERE idUsuario=_idu;
RETURN 1;
END */$$
DELIMITER ;

/* Function  structure for function  `modificaDepartamento` */

/*!50003 DROP FUNCTION IF EXISTS `modificaDepartamento` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `modificaDepartamento`( _idD INT,_nombre VARCHAR(100), _estatus INT) RETURNS int(11)
BEGIN
UPDATE departamentos 
SET nombre=_nombre, idEstatus=_estatus
WHERE idDepartamento=_idD;
RETURN 1;
END */$$
DELIMITER ;

/* Function  structure for function  `modificaEdificio` */

/*!50003 DROP FUNCTION IF EXISTS `modificaEdificio` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `modificaEdificio`( _idE INT,_nombre VARCHAR(100), _piso VARCHAR(100),_estatus INT) RETURNS int(11)
BEGIN
UPDATE edificios
SET nombre=_nombre, idEstatus=_estatus, piso=_piso
WHERE idEdificio=_idE;
RETURN 1;
END */$$
DELIMITER ;

/* Function  structure for function  `modificaMicrocontrolador` */

/*!50003 DROP FUNCTION IF EXISTS `modificaMicrocontrolador` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `modificaMicrocontrolador`( _idMicrocontrolador int,_idModelo INT, _idEstatus INT, _ip VARCHAR(45), _mac VARCHAR(45) , _nombre VARCHAR(100)) RETURNS int(11)
BEGIN
UPDATE microcontrolador AS m SET m.`idModelo`=_idModelo, m.`ip`=_ip,
 m.`mac`=_mac, m.`idEstatus`=_idEstatus, m.`nombre`=_nombre 
WHERE m.`idMicrocontrolador`= _idMicrocontrolador;
RETURN 1;
END */$$
DELIMITER ;

/* Function  structure for function  `modificaUsuario` */

/*!50003 DROP FUNCTION IF EXISTS `modificaUsuario` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `modificaUsuario`( _idu int ,_nombre VARCHAR(45), _app VARCHAR(45), _apm VARCHAR(45), 
_usuario VARCHAR(45), _departamento INT, _tipoUsuario INT, _estatus INT) RETURNS int(11)
begin
UPDATE usuarios AS u SET u.`nombre`=_nombre ,u.`app`=_app, u.`apm`=_apm, u.`correo`=_usuario, 
u.`idDepartamento`=_departamento, u.`idTipoUsuario`=_tipoUsuario ,u.`idEstatusUsuario`=_estatus 
WHERE u.`idUsuario`=_idu ;
RETURN 1;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
