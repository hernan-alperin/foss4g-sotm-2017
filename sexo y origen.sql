
-----------------------------------------------------------------------
-- HAY QUE DISTINGUIR POR NOMBRES LOS REPETIDOS 
-- Alvarez, Álvarez, ALVAREZ, etc
-- para se usa "Correo electrónico" como identificador único de persona
-- para 2017
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

with distintos as (select distinct email, pais from email_asistentes_2017 where pais != 'ar' and pais is not null),
     exterior as (select count(*) as exterior from distintos)
select case
                when pais = 'ni' then 'Nicaragua'
                when pais = 'gt' then 'Guatemala'
                when pais = 'py' then 'Paraguay'
                when pais = 'pe' then 'Perú'
                when pais = 'uy' then 'Uruguay'
                when pais = 'co' then 'Colombia'
                when pais = 'mx' then 'Méjico'
                when pais = 'es' then 'España'
                when pais = 'us' then 'Estados Unidos'
                when pais = 'br' then 'Brasil'
                when pais = 'cl' then 'Chile'
               end as nombre_pais,
        count(*),
        (100.0*count(*)/exterior) as porcentaje,
        Null as porcentaje_redondeado_a_suma_100
from distintos, exterior
where pais != 'ar' and pais is not null
group by nombre_pais, exterior
order by count desc, exterior
;

  nombre_pais   | count |     porcentaje      | porcentaje_redondeado_a_suma_100
----------------+-------+---------------------+----------------------------------
 Chile          |     8 | 23.5294117647058824 | 24
 Estados Unidos |     5 | 14.7058823529411765 | 14
 Brasil         |     5 | 14.7058823529411765 | 14
 España         |     4 | 11.7647058823529412 | 12
 Méjico         |     3 |  8.8235294117647059 | 9
 Perú           |     2 |  5.8823529411764706 | 6
 Uruguay        |     2 |  5.8823529411764706 | 6
 Colombia       |     2 |  5.8823529411764706 | 6
 Nicaragua      |     1 |  2.9411764705882353 | 3
 Guatemala      |     1 |  2.9411764705882353 | 3
 Paraguay       |     1 |  2.9411764705882353 | 3
                         ----                  ----
                          102                   100 
                          (hay que sacar 2...)
 


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

