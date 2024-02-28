-- -------------------------------------------------------------------------------------------------------------------------
/*                                           STORED PROCEDURES                                                            */
-- -------------------------------------------------------------------------------------------------------------------------
-- 1) INSERCIÓN DE REGISTRO EN LA TABLA ACTIVIDADES: 
DELIMITER //
create procedure insertar_actividad (in actividad varchar(50)) 
begin
	insert into actividades (id_actividad, actividad) values (null, actividad);
end//
call insertar_actividad ('Rafting'); -- Ejemplo de llamado al procedimiento para insertar un registro

-- 2) ELIMINACIÓN DE REGISTRO EN LA TABLA ACTIVIDADES: 
DELIMITER //
create procedure eliminar_actividad (in id int)
begin
	delete from actividades where id_actividad=id;
end //
call eliminar_actividad (11); -- Ejemplo de llamado al procedimiento para eliminar un registro

-- 3) PROCEDIMIENTO ALMACENADO QUE PERMITE ORDENAR REGISTROS TIPO VARCHAR DE UNA TABLA, CON ORDEN ASCENDENTE O DESCENDENTE: 
DELIMITER //
create procedure ordenar_tabla(
	in tabla varchar(50), --  Nombre de la tabla que se va a ordenar
	in columna varchar(50), -- Aqui especifico en función de que campo de la tabla quiero ordenar la tabla
	in tipo_orden varchar(5) -- Aqui especifico que tipo de orden quiero, ascendente o descendente
)
begin
	declare clausula varchar(50); -- Declaro la variable temporal "clausula"
    set @clausula = -- Genero la variable que va a ordenar los parametros de entrada
		concat( -- utilizo concat para concatenar la consulta
        ' select*from ', tabla ,
        ' order by ', columna ,
        ' ', tipo_orden);
	-- Con la variable runSQL almaceno temporalmente la @consulta
    prepare runSQL from @clausula; -- utilizo prepare para preparar la consulta
    execute runSQL; -- utilizo execute para ejecutar la consulta
    deallocate prepare runSQL; -- utilizo deallocate prepare para borrar la memoria que se había reservado con la variable temporal runSQL
end//
call ordenar_tabla('personas', 'nombre', 'DESC'); -- Ejemplo de llamado al procedimiento para ordenar la tabla personas
call ordenar_tabla('idiomas', 'idioma', 'ASC'); -- Ejemplo de llamado al procedimiento para ordenar la tabla idiomas
