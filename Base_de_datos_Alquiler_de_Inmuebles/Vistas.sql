-- -------------------------------------------------------------------------------------------------------------------------------------
/*                                                      CREACIÓN DE VISTAS                                                           */ 
-- -------------------------------------------------------------------------------------------------------------------------------------
-- 1) PERSONAS REGISTRADAS QUE VIVEN EN ARGENTINA
create view paises_de_procedencia_personas as
select 
T1.nombre,
T1.apellido,
T2.pais
from
personas T1
inner join paises T2
on T1.pais=T2.id_pais;

-- 2) DATOS DE CONTACTO DE PERSONAS CON RESERVAS 
create view contacto_personas_con_reserva as
select
T2.nombre,
T2.apellido,
T2.telefono,
T2.email
from reservas T1
inner join personas T2
on T1.persona = T2.id_persona;

-- 3) GASTO Y ALOJAMIENTO DE PERSONAS CON RESERVAS
create view gasto_alojamiento_por_persona as
select
T3.nombre,
T3.apellido,
T4.alojamiento,
T2.importe
from
medios T1
inner join transacciones T2
on T1.id_medio=T2.medio
inner join personas T3
on T1.persona=T3.id_persona
inner join reservas T4
on T3.id_persona=T4.persona;

-- 4) ACTIVIDADES Y CARACTERISTICAS POR ALOJAMIENTO
create view actividades_y_caracteristicas_por_alojamiento as
select
T1.nombre as nombre_alojamiento,
T2.actividad as Actividades_para_realizar,
T3.caracteristica as Caracteristicas_sobresalientes
from alojamientos T1
inner join actividades T2
on T1.actividades=T2.id_actividad
inner join caracteristicas T3
on T1.caracteristicas=T3.id_caracteristica;

-- 5) Idiomas que son hablantes las personas
create view idiomas_de_personas as
select
T1.nombre,
T1.apellido,
T2.idioma
from personas T1
inner join idiomas T2
on T1.idioma=T2.id_idioma;
