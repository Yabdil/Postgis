-- We had multiple iner polygons inside our polygons, the goal was to find a query removing the iner polygon

SELECT ST_GeomFromText(polygone) as geom

   from (

    SELECT st_astext(ST_MakePolygon(linear)) as polygone

        from (
              SELECT st_astext
                ((ST_dump
                   (st_boundary
                      (ST_MakeValid
                      -- Transforming the coordinate system in order to calculate the area
                     (ST_Transform
                        (ST_SETSRID
                           (geometry,4326),32631))))).geom) 
                          as linear from tables_name)
        as query2)

  as query1

where ST_area(polygone) > 1