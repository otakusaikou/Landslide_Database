--Insert values (basin_id, basin) from table result which is not exist in table basin
INSERT INTO public.basin
SELECT DISTINCT basin_id, basin
FROM public.result
WHERE basin_id NOT IN (SELECT basin_id
                       FROM basin);

--Insert values (forest_id, forest_dis) from table result which is not exist in table forest_district
INSERT INTO public.forest_district
SELECT DISTINCT forest_id, forest_dis
FROM public.result
WHERE forest_id NOT IN (SELECT forest_id
                        FROM forest_district);
                       
--Insert values (reserv_id, reservoir) from table result which is not exist in table reservoir
INSERT INTO public.reservoir
SELECT DISTINCT reserv_id, reservoir
FROM public.result
WHERE reserv_id NOT IN (SELECT reservoir_id
                        FROM reservoir);
                        
--Insert values (watersh_id, watershed) from table result which is not exist in table watershed
INSERT INTO public.watershed
SELECT DISTINCT watersh_id, watershed
FROM public.result
WHERE watersh_id NOT IN (SELECT water_id
                         FROM watershed);
                        
--Insert values (working_id, working_ci) from table result which is not exist in table working_circle
INSERT INTO public.working_circle
SELECT DISTINCT working_id, working_ci
FROM public.result
WHERE working_id NOT IN (SELECT workingcircle_id
                         FROM working_circle);
                         
--Insert values (county_id, town_id, county, township) from table result which is not exist in table admin_area
INSERT INTO public.admin_area
SELECT DISTINCT county_id, town_id, county, township
FROM public.result
WHERE (county_id, town_id) NOT IN (SELECT county_id, town_id
                                   FROM admin_area);
                                   
                                   
--Insert values (project) from table result which is not exist in table project, the sequence before project is project_id
INSERT INTO public.project 
SELECT nextval('project_id_area_gid_seq'::regclass), project
FROM (SELECT DISTINCT project
      FROM public.result
      WHERE project NOT IN (SELECT project_name
                            FROM public.project)) AS T;
                            
--Insert values [dmcname(unnested), dmcdate, project_id(referenced from table project)] from table result which is not exist in table image
INSERT INTO public.image
SELECT image, dmcdate::date, project_id
FROM (SELECT DISTINCT project_id
      FROM public.result JOIN public.project ON project = project_name) T3,
     (SELECT image, dmcdate
      FROM (SELECT image, dmcdate
            FROM (SELECT DISTINCT unnest(string_to_array(replace(replace(dmcname, '{', ''), '}', ''), ',')) image, dmcdate
                  FROM public.result) AS T
            ORDER BY image) AS T2) T4;
            
--Insert values [slide_id, centroid_x, centroid_y, area, geom, dmcname(unnested), county_id, town_id, working_id, reserv_id, watersh_id, forest_id, basin_id] from table result which is not exist in table slide_area
INSERT INTO public.slide_area
SELECT slide_id, centroid_x, centroid_y, area, geom, unnest(dmcname) image_name, county_id, town_id, working_id, reserv_id, watersh_id, forest_id, basin_id
FROM (SELECT DISTINCT nextval('slide_id_area_gid_seq'::regclass) slide_id, centroid_x, centroid_y, area, geom, string_to_array(replace(replace(dmcname, '{', ''), '}', ''), ',') dmcname, county_id, town_id, working_id, reserv_id, watersh_id, forest_id, basin_id
      FROM public.result) AS T;