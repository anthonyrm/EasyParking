--
-- Script was generated by Devart dbForge Studio for MySQL, Version 7.1.13.0
-- Product home page: http://www.devart.com/dbforge/mysql/studio
-- Script date 21/05/2016 11:36:13 a.m.
-- Server version: 5.5.35
-- Client version: 4.1
--


-- 
-- Disable foreign keys
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Set SQL mode
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Set default database
--
USE easyparking1;

--
-- Definition for table state
--
DROP TABLE IF EXISTS state;
CREATE TABLE state (
  Id INT(2) NOT NULL,
  Description VARCHAR(45) DEFAULT NULL,
  PRIMARY KEY (Id)
)
ENGINE = INNODB
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table spot
--
DROP TABLE IF EXISTS spot;
CREATE TABLE spot (
  Id INT(3) NOT NULL,
  IdUbication INT(4) DEFAULT NULL,
  State VARCHAR(2) DEFAULT NULL,
  Level VARCHAR(2) DEFAULT NULL,
  UbicationNumber INT(3) DEFAULT NULL,
  IdParking INT(2) DEFAULT NULL,
  IdState INT(2) DEFAULT NULL,
  PRIMARY KEY (Id),
  INDEX SpotParking_idx (IdParking),
  INDEX SpotState_idx (IdState),
  UNIQUE INDEX UK_spot_IdUbication (IdUbication),
  CONSTRAINT SpotState FOREIGN KEY (IdState)
    REFERENCES state(Id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table reserva
--
DROP TABLE IF EXISTS reserva;
CREATE TABLE reserva (
  Id INT(3) NOT NULL,
  RegisterDate DATETIME DEFAULT NULL,
  ArrivalDate DATETIME DEFAULT NULL,
  IdUser INT(4) DEFAULT NULL,
  State INT(2) DEFAULT NULL,
  IdUbication INT(6) DEFAULT NULL,
  idLocation INT(2) DEFAULT NULL,
  PRIMARY KEY (Id),
  UNIQUE INDEX UK_reserva_idLocation (idLocation),
  UNIQUE INDEX UK_reserva_IdUser (IdUser),
  CONSTRAINT FK_reserva_spot_IdUbication FOREIGN KEY (IdUbication)
    REFERENCES spot(IdUbication) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table parkinglot
--
DROP TABLE IF EXISTS parkinglot;
CREATE TABLE parkinglot (
  IdDistrict INT(3) NOT NULL,
  DistrictDescription VARCHAR(45) DEFAULT NULL,
  IdLocation INT(2) DEFAULT NULL,
  NameParking VARCHAR(45) DEFAULT NULL,
  Location VARCHAR(45) DEFAULT NULL,
  PRIMARY KEY (IdDistrict),
  UNIQUE INDEX UK_parkinglot_IdLocation (IdLocation),
  CONSTRAINT FK_parkinglot_reserva_idLocation FOREIGN KEY (IdLocation)
    REFERENCES reserva(idLocation) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table user
--
DROP TABLE IF EXISTS user;
CREATE TABLE user (
  Id_User INT(4) NOT NULL,
  UserName VARCHAR(45) DEFAULT NULL,
  UserApellido VARCHAR(45) DEFAULT NULL,
  UserLicensePlate VARCHAR(6) DEFAULT NULL,
  Contraseņa VARCHAR(10) NOT NULL,
  PRIMARY KEY (Id_User),
  CONSTRAINT FK_user_reserva_IdUser FOREIGN KEY (Id_User)
    REFERENCES reserva(IdUser) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table parkingmap
--
DROP TABLE IF EXISTS parkingmap;
CREATE TABLE parkingmap (
  Id INT(2) NOT NULL,
  Name VARCHAR(45) DEFAULT NULL,
  Description VARCHAR(45) DEFAULT NULL,
  Latitude VARCHAR(45) DEFAULT NULL,
  Length VARCHAR(45) DEFAULT NULL,
  IdLocation INT(2) DEFAULT NULL,
  PRIMARY KEY (Id),
  CONSTRAINT FK_parkingmap_parkinglot_IdLocation FOREIGN KEY (IdLocation)
    REFERENCES parkinglot(IdLocation) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

DELIMITER $$

--
-- Definition for procedure GET_INSERT_RESERVATION
--
DROP PROCEDURE IF EXISTS GET_INSERT_RESERVATION$$
CREATE DEFINER = 'root'@'localhost'
PROCEDURE GET_INSERT_RESERVATION(
  IN Id_reserva int(11), 
  IN dte_RegisterDate datetime, 
  IN dte_ArrivalDate datetime, 
  IN Id_User int(11), 
  IN Id_State int(11), 
  IN Id_IdUbication int(6))
BEGIN 

  INSERT INTO RESERVATION (Id,RegisterDate,ArrivalDate,IdUser,State,IdUbication)
  VALUES (Id_reserva, dte_RegisterDate, dte_ArrivalDate, id_user, Id_State, Id_IdUbication);

  END
$$

--
-- Definition for procedure GET_INSERT_SPOT
--
DROP PROCEDURE IF EXISTS GET_INSERT_SPOT$$
CREATE DEFINER = 'root'@'localhost'
PROCEDURE GET_INSERT_SPOT(
  IN Id_spot int(11), 
  IN s_IdUbication int(4), 
  IN p_State varchar(45),
  IN p_Level varchar(45), 
  IN p_UbicationNumber int(11), 
  IN p_IdParking int(11),
  IN p_IdState int(11))
BEGIN 

  INSERT INTO spot ( Id,IdUbication,State,Level,UbicationNumber,IdParking,IdState)
    VALUES (Id_spot,s_IdUbication,p_State,p_Level,p_UbicationNumber,p_IdParking,p_IdState);
   
END
$$

--
-- Definition for procedure GET_PARKING_BY_ID
--
DROP PROCEDURE IF EXISTS GET_PARKING_BY_ID$$
CREATE DEFINER = 'root'@'localhost'
PROCEDURE GET_PARKING_BY_ID(_id int)
begin select Id, Name, Description, Latitude, Length from Parking where Id = _id;end
$$

--
-- Definition for procedure GET_SELECT_PARKINGLOT
--
DROP PROCEDURE IF EXISTS GET_SELECT_PARKINGLOT$$
CREATE DEFINER = 'root'@'localhost'
PROCEDURE GET_SELECT_PARKINGLOT(
    IN pa_IdDistrict int(6), 
    OUT pa_DistrictDescription varchar(100),
    OUT pa_IdLocation int(4),
    OUT pa_NameParking varchar(100),
    OUT pa_Location varchar(100))
BEGIN 
    SELECT DistrictDescription,IdLocation,NameParking,Location
      INTO pa_DistrictDescription,pa_IdLocation,pa_NameParking,pa_Location
    FROM PARKINGLOT 
      WHERE IdDistrict = pa_IdDistrict;
END
$$

--
-- Definition for procedure GET_UPDATE_RESERVATION
--
DROP PROCEDURE IF EXISTS GET_UPDATE_RESERVATION$$
CREATE DEFINER = 'root'@'localhost'
PROCEDURE GET_UPDATE_RESERVATION(
  IN Id_reserva int(11), 
  IN dte_RegisterDate datetime, 
  IN dte_ArrivalDate datetime, 
  IN Id_User int(11), 
  IN Id_State int(11), 
  IN Id_IdUbication int(6))
BEGIN 

  UPDATE reservation
    SET
    STATE = Id_State
  WHERE ID = USER_ID;

END
$$

--
-- Definition for procedure GET_UPDATE_USER
--
DROP PROCEDURE IF EXISTS GET_UPDATE_USER$$
CREATE DEFINER = 'root'@'localhost'
PROCEDURE GET_UPDATE_USER(
  IN USER_ID int(11), 
  IN USER_NOMBRE varchar(100), 
  IN USER_APELLIDO varchar (100), 
  IN USER_LICENSE VARCHAR(45),
  IN USER_CONTRA VARCHAR(10))
BEGIN

  UPDATE USER
    SET 
    NOMBRE = USER_NOMBRE,
    APELLIDO = USER_APELLIDO,
    LICENSEPLATE = USER_LICENSE,
    CONTRASEŅA = USER_CONTRA
    WHERE ID = USER_ID;
 
  END
$$

--
-- Definition for procedure GET_USERS
--
DROP PROCEDURE IF EXISTS GET_USERS$$
CREATE DEFINER = 'root'@'localhost'
PROCEDURE GET_USERS()
begin
select Id, LicensePlate from User;
end
$$

DELIMITER ;

-- 
-- Dumping data for table state
--

-- Table easyparking1.state does not contain any data (it is empty)

-- 
-- Dumping data for table spot
--

-- Table easyparking1.spot does not contain any data (it is empty)

-- 
-- Dumping data for table reserva
--

-- Table easyparking1.reserva does not contain any data (it is empty)

-- 
-- Dumping data for table parkinglot
--

-- Table easyparking1.parkinglot does not contain any data (it is empty)

-- 
-- Dumping data for table user
--

-- Table easyparking1.user does not contain any data (it is empty)

-- 
-- Dumping data for table parkingmap
--

-- Table easyparking1.parkingmap does not contain any data (it is empty)

-- 
-- Restore previous SQL mode
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Enable foreign keys
-- 
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;