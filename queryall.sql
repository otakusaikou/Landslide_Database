SELECT *
FROM (SELECT slide_id, project_name AS project, array_agg(image_name) AS image_name, image_date, workingcircle_name, forest_name, county_name, town_name, reservoir_name, water_name, basin_name, area, centroid_x, centroid_y, geom
      FROM slide_area, image, project, admin_area, working_circle, reservoir, watershed, forest_district, basin
      WHERE image_no = image_name AND project_no = project_id AND county_no = county_id AND town_no = town_id AND workingcircle_no = workingcircle_id AND reservoir_no = reservoir_id AND water_no = water_id AND forest_no = forest_id AND basin_no = basin_id
      GROUP BY slide_id, geom, project_name, image_date, workingcircle_name, forest_name, county_name, town_name, reservoir_name, water_name, basin_name, area, centroid_x, centroid_y) AS T
--WHERE array_length(image_name, 1) > 3 --Uncomment this line if you want to query landslides which appear in more than three photos. 