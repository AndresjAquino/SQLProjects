
-- ---------------------------------------------------------------------------------------------------------------------------
/*                                                    TRIGGERS                                                              */
-- ---------------------------------------------------------------------------------------------------------------------------
/*   1) BITACORA DE INSERCIONES PARA TABLA RESERVAS   */
-- ------------------------------------------------------
create table bitacora_reservas_insercion(-- Creo tabla bitacora que almacenara información del usuario, fecha y hora de las inserciones que realice
	id_insercion int not null auto_increment primary key,
	id_reserva int not null,
	usuario varchar(50) not null,
	fecha_insercion datetime not null
);

DELIMITER // -- Creación del trigger que detecta la inserción de un registro en la tabla reservas
create trigger bitacora_reservas_insercion
	after insert on reservas -- El trigger se ejecutará despues (AFTER) de cada inserción en la tabla reservas y registrará la información en la tabla bitacora_reservas_inserción.
	for each row -- Aqui se especifica que se ejecute para cada registro
	begin
		insert into bitacora_reservas_insercion(
        id_reserva,
        usuario,
        fecha_insercion)
		values (new.id_reserva, user(), curtime());
	end;//
-- ---------------------------------------------------
-- Realizo una inserción de ejemplo
insert into reservas(
	id_reserva,
    persona,
    alojamiento,
    checkin,
    checkout,
    precio_dia)
values
	(null,5,3,'2023-06-01','2023-06-07',450.50);
select*from reservas;
select*from bitacora_reservas_insercion;
-- ----------------------------------------------------------
/*    2) BITACORA DE ELIMINACIONES PARA TABLA RESERVAS    */
-- ----------------------------------------------------------
create table bitacora_reservas_eliminacion( -- Creo tabla bitacora que almacenara información del usuario, fecha y hora de los delete que realice
  id_eliminacion int not null auto_increment primary key,
  id_reserva int not null,
  usuario varchar(50) not null,
  fecha_eliminacion datetime not null
);

DELIMITER // -- Creación del trigger que detecta la eliminación de un registro en la tabla reservas
create trigger bitacora_reservas_eliminacion
	before delete on reservas -- El trigger se ejecutará antes (BEFORE) de cada eliminación en la tabla reservas y registrará la información en la tabla bitacora_reservas_eliminacion. 
	for each row -- Aqui se especifica que se dispare para cada registro
	begin
		insert into bitacora_reservas_eliminacion(
        id_reserva,
        usuario,
        fecha_eliminacion) 
		values (old.id_reserva, user(), curtime());
	end;//
-- Ejemplo de eliminación, realizo un delete del registro insertado en el ejercicio anterior
delete from reservas where id_reserva=3;
select*from reservas;
select*from bitacora_reservas_eliminacion;
