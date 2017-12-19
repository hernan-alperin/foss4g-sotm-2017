-- cantidad de asistentes acreditados, participantes o cambiados...
select substr("Fecha de pedido",1,4) as "año", "Nombre del evento", count(*)
from asistentes
where "Estado del participante" in ('Acreditado', 'Participa', 'Cambiado')
group by substr("Fecha de pedido",1,4), "Nombre del evento"
order by substr("Fecha de pedido",1,4), "Nombre del evento"
;

 año  |                                    Nombre del evento                                     | count
------+------------------------------------------------------------------------------------------+-------
 2016 | Encuentro de Geodatos Abiertos                                                           |    79
 2016 | FOSS4G Argentina 2016                                                                    |   189
 2016 | Taller: Análisis espacial con R                                                          |    28
 2016 | Taller: Geoinformática aplicada a la cartografía                                         |    27
 2016 | Taller: GeoNetwork Avanzado                                                              |    25
 2016 | Taller: Introducción a CartoDB                                                           |    24
 2016 | Taller: Introducción a GeoNetwork                                                        |    28
 2016 | Taller: Introducción a GeoServer                                                         |    28
 2016 | Taller: Introducción a Leaflet                                                           |    28
 2016 | Taller: Leaflet Avanzado - Cómo hacer plugins                                            |    28
 2016 | Taller: QGIS II - Creación de datos geoespaciales                                        |    36
 2016 | Taller: QGIS III - Geoprocesos                                                           |    40
 2016 | Taller: QGIS I - Introducción                                                            |    31
 2016 | Taller: TGRASS - Procesamiento de series de tiempo en GRASS GIS                          |    31
 2017 | FOSS4G + SOTM 2017 ARGENTINA                                                             |   152
 2017 | Jornada sobre el Software Libre de Geomática y SIG aplicado a Educación e Investigación  |    18
 2017 | Mapatón / Hackatón                                                                       |    46
 2017 | Pre Taller: Introducción a QGIS                                                          |     5
 2017 | Taller Carto Builder                                                                     |    30
 2017 | Taller Generación y publicación de tiles vectoriales                                     |     7
 2017 | Taller GeoNetwork Avanzado                                                               |    15
 2017 | Taller Geonetwork Geoinquietos-IDERA                                                     |    17
 2017 | Taller GeoServer                                                                         |    20
 2017 | Taller Introducción a GeoNetwork                                                         |    17
 2017 | Taller Introducción a QGIS                                                               |    27
 2017 | Taller OSM ID                                                                            |    30
 2017 | Taller Personalizacion de GeoNode y como comunicar una IDE                               |    14
 2017 | Taller pgRouting                                                                         |    27
 2017 | Taller PostGIS                                                                           |    27
 2017 | Taller Pre Conferencia Base de datos geoespaciales con PostGIS                           |    51
 2017 | Taller Pre Conferencia Introducción al uso de Python en SIG                              |    48
 2017 | Taller QGIS + PostGIS                                                                    |     4
 2017 | Taller QGIS Superavanzado                                                                |    38
 2017 | Taller Teledetección con QGIS                                                            |    27
 2017 | Webinario Base de datos geoespaciales con PostGIS                                        |   122
 2017 | Webinario Base de datos geoespaciales con PostGIS II                                     |    92
 2017 | Webinario: Implementación de estándares de IDERA con Software libre. Parte I             |    94
(37 filas)

-- cantidad de eventos por año
with eventos as (
  select substr("Fecha de pedido",1,4) as "año", count(*), "Nombre del evento"
  from asistentes
  where "Estado del participante" in ('Acreditado', 'Participa', 'Cambiado')
  group by substr("Fecha de pedido",1,4), "Nombre del evento"
  )
select "año", count(*)
from eventos
group by "año"
order by count
;

 año  | count
------+-------
 2016 |    14
 2017 |    23
(2 filas)

-- tipos de eventos
with eventos as (
  select substr("Fecha de pedido",1,4) as "año", "Nombre del evento", count(*)
  from asistentes
  where "Estado del participante" in ('Acreditado', 'Participa', 'Cambiado')
  group by substr("Fecha de pedido",1,4), "Nombre del evento"
  order by substr("Fecha de pedido",1,4), "Nombre del evento"
  )
select "año", 
  case
    when "Nombre del evento" ilike '%taller%' then 'Talleres'
    when "Nombre del evento" ilike '%webinario%' then 'Webinarios'
    else "Nombre del evento" 
  end as "Tipo de evento",
  count(*)
from eventos
group by "año", "Tipo de evento"
order by "año", "Tipo de evento"
;

 año  |                                      Tipo de evento                                      | count
------+------------------------------------------------------------------------------------------+-------
 2016 | Encuentro de Geodatos Abiertos                                                           |     1
 2016 | FOSS4G Argentina 2016                                                                    |     1
 2016 | Talleres                                                                                 |    12
 2017 | FOSS4G + SOTM 2017 ARGENTINA                                                             |     1
 2017 | Jornada sobre el Software Libre de Geomática y SIG aplicado a Educación e Investigación  |     1
 2017 | Mapatón / Hackatón                                                                       |     1
 2017 | Talleres                                                                                 |    17
 2017 | Webinarios                                                                               |     3
(8 filas)

-- cantidad de asistentes acreditados, participantes o cambiados por tipo de evento
with distintos as (select distinct "Correo electrónico" as email,
                   substr("Fecha de pedido",1,4) as "año",
                   case
                      when "Nombre del evento" ilike '%taller%' then 'Talleres'
                      when "Nombre del evento" ilike '%webinario%' then 'Webinarios'
                   else "Nombre del evento" 
                   end as "Tipo de evento"
                   from asistentes
                   where "Estado del participante" in ('Acreditado', 'Participa', 'Cambiado'))
-- para evitar repetición en tipo de evento
-- el único campo útil es "Correo electrónico", siempre presente
select "año", "Tipo de evento", count(*)
from distintos
group by "año", "Tipo de evento"
order by "año", "Tipo de evento"
;

 año  |                                      Tipo de evento                                      | count
------+------------------------------------------------------------------------------------------+-------
 2016 | Encuentro de Geodatos Abiertos                                                           |    78
 2016 | FOSS4G Argentina 2016                                                                    |   188
 2016 | Talleres                                                                                 |   151
 2017 | FOSS4G + SOTM 2017 ARGENTINA                                                             |   148
 2017 | Jornada sobre el Software Libre de Geomática y SIG aplicado a Educación e Investigación  |    18
 2017 | Mapatón / Hackatón                                                                       |    45
 2017 | Talleres                                                                                 |   216
 2017 | Webinarios                                                                               |   244
(8 filas)

