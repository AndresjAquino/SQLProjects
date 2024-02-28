-- -------------------------------------------------------------------------------------------------------------------------
/*                                           FUNCIONES PERSONALIZADAS                                                     */
-- -------------------------------------------------------------------------------------------------------------------------
-- 1) FUNCIÓN PARA CALCULAR EL PRECIO EL PRECIO DE LA ESTADIA EN EL ALOJAMIENTO
DELIMITER //
create function costo_alojamiento (checkin date,checkout date,precio_dia numeric(6,2))
returns numeric(6,2)
deterministic
begin
	declare dias int; -- cuenta los dias entre el checkin y el checkout
    declare resultado numeric(6,2);-- multiplica los dias por el precio diario del alojamiento
	set dias = checkout-checkin;
	set resultado=precio_dia*dias;
	return resultado;
end;
//
select costo_alojamiento('2023-05-03','2023-05-10',200);

-- 2) FUNCIÓN PARA DETERMINAR SI APLICAR UNA BONIFICACIÓN O NO A UN CLIENTE FRECUENTE
DELIMITER //
create function bonificacion_cliente (id_persona int)
returns varchar(50)
deterministic
begin
	declare n_reservas int;
    declare mensaje varchar(25);
    set n_reservas = (select count(id_reserva) from reservas where persona=id_persona);
	if n_reservas>=1 then
    set mensaje= 'Aplicar Bonificación';
	else
    set mensaje= 'NO aplicar Bonificación';
    end if;
    return mensaje;
end;
//
select bonificacion_cliente (1), bonificacion_cliente(2), bonificacion_cliente(3);
