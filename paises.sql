select "Ciudad y País de Residencia", count(*)
from asistentes
where "Estado del participante" in ('Acreditado', 'Participa', 'Cambiado')
and substr("Fecha de pedido", 1, 4) = '2017'
group by "Ciudad y País de Residencia"
order by count desc
;

-----------------------------------------------------------------------
-- OJO ESTO NO VALE, HAY QUE DISTINGUIR POR NOMBRES LOS REPETIDOS    --
-- Alvarez, Álvarez, ALVAREZ, etc
-----------------------------------------------------------------------

drop table email_asistentes_2017;
create table email_asistentes_2017 as  -- para determinar únicos
select distinct "Correo electrónico" as email, "Nombre" as nombre,
        "Ciudad y País de Residencia" as ciudad_pais
from asistentes
where "Estado del participante" in ('Acreditado', 'Participa', 'Cambiado')
and substr("Fecha de pedido", 1, 4) = '2017'
;

alter table email_asistentes_2017 add column pais text;
alter table email_asistentes_2017 add column sexo text;
alter table email_asistentes_2017 add column id serial primary key;
-- y a editar con pgadmin...

with distintos as (select distinct email, sexo
        from email_asistentes_2017)
        select sexo, count(*)
        from distintos
        group by sexo
;


 sexo | count
------+-------
      |     2
 F    |   198
 M    |   347
(3 filas)

select 100.0*198/(198 + 347);
select 100.0*347/(198 + 347);

F 36%
M 64%

with distintos as (select distinct email, pais
        from email_asistentes_2017)
        select pais, count(*)
        from distintos
        group by pais
        order by count
;

 pais | count
------+-------
 ni   |     1
 gt   |     1
 py   |     1
 pe   |     2
 uy   |     2
 co   |     2
 mx   |     3
 es   |     4
 us   |     5
 br   |     5
 cl   |     8
      |   269
 ar   |   271
(13 filas)

with distintos as (select distinct email, pais
        from email_asistentes_2017)
        select case 
                when pais = 'ar' then 'Argentina' 
                else 'Exterior'        
                end as donde, 
                count(*)
        from distintos
        where pais is not Null and pais != ''
        group by case 
                when pais = 'ar' then 'Argentina' 
                else 'Exterior'        
                end
        order by count
;

   donde   | count
-----------+-------
 Exterior  |    34
 Argentina |   271
(2 filas)

select 100.0*34/(34 + 271);
select 100.0*271/(34 + 271);

Exterior 11%
Argentina 89%

