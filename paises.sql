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

(!) No. Hay que selecionar asistentes distintos


        Ciudad y País de Residencia         | count
--------------------------------------------+-------
                                            |  1046
 Argentina                                  |    64
 Buenos Aires, Argentina                    |    33
 CABA, Argentina                            |    25
 CABA                                       |    17
 Ciudad de Buenos Aires                     |    16
 CABA - Argentina                           |    13
 Buenos Aires                               |    13
 Rosario, Argentina                         |    12
 Rosario, Santa Fe, Argentina               |    10
 Buenos Aires Argentina                     |     9
 Corrientes Argentina                       |     8
 Mendoza, Argentina                         |     8
 United States                              |     8
 cordoba                                    |     8
 Santiago                                   |     7
 Comodoro Rivadavia                         |     7
 Neuquen, Argentina                         |     7
 CORDOBA                                    |     7
 Córdoba Argentina                          |     5

select count(*) from asistentes;
 count
-------
  1723

-- 1047 de 1723 no sabemos de donde vinieron ... más del 60%


:-P

copiando y pegando, cherry picking...
 United States                              |     8
 Santiago                                   |     7     (asumo Chile)
 Santiago, Chile                            |     5
 Ellensburg, estado de Washington, EEUU     |     4
 Brasil                                     |     3
 Pato Branco - BRASIL                       |     3
 Santiago de Chile                          |     2
 USA                                        |     1
 Ellensburg, Washington, Estados Unidos     |     1
 Melipilla - Chile                          |     1
 Asunción de Paraguay                       |     1
 Sevilla                                    |     1
 Guatemala                                  |     1
 Managua                                    |     1



--Hay que selecionar asistentes distintos

with distintos as (
  select translate(lower("Apellido"),'áéíóúü-, ','aeiouu'), translate(lower("Nombre"),'áéíóúü-, ','aeiouu'), count(*)
  from asistentes
  where "Estado del participante" in ('Acreditado', 'Participa', 'Cambiado')
  and substr("Fecha de pedido",1,4) = '2017'
  group by lower("Apellido"), lower("Nombre")
  order by lower("Apellido"), lower("Nombre")
  )
select * from distintos
;

        
        
        
select "Ciudad y País de Residencia", count(*)
from asistentes
where "Estado del participante" in ('Acreditado', 'Participa', 'Cambiado')
group by "Ciudad y País de Residencia"
order by count desc
;

