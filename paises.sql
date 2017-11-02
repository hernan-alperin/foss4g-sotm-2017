select "Ciudad y País de Residencia", COUNT(*)
from asistentes
where "Estado del participante" in ('Acreditado', 'Participa', 'Cambiado')
group by "Ciudad y País de Residencia"
order by count desc
;

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
