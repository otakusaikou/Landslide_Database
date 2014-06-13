--Delete old tables
DROP TABLE IF EXISTS public.slide_area;
DROP TABLE IF EXISTS public.image;
DROP TABLE IF EXISTS public.project;


--Create table admin_area, primary key is (county_id, town_id)
DROP TABLE IF EXISTS public.admin_area;
CREATE TABLE public.admin_area
(
  county_id character varying(5),
  town_id character varying(10),
  county_name character varying(50),
  town_name character varying(50),
  CONSTRAINT ADMINPK PRIMARY KEY (county_id, town_id)
);

--Create table working_circle, primary key is workingcircle_id
DROP TABLE IF EXISTS public.working_circle;
CREATE TABLE public.working_circle
(
  workingcircle_id character varying(2),
  workingcircle_name character varying(50),
  CONSTRAINT WORKPK PRIMARY KEY (workingcircle_id)
);

--Create table watershed, primary key is water_id
DROP TABLE IF EXISTS public.watershed;
CREATE TABLE public.watershed
(
  water_id character varying(10),
  water_name character varying(30),
  CONSTRAINT WARTERPK PRIMARY KEY (water_id)
);

--Create table forest_district, primary key is forest_id
DROP TABLE IF EXISTS public.forest_district;
CREATE TABLE public.forest_district
(
  forest_id character varying(2),
  forest_name character varying(50),
  CONSTRAINT FORESTPK PRIMARY KEY (forest_id)
);

--Create table reservoir, primary key is reservoir_id
DROP TABLE IF EXISTS public.reservoir;
CREATE TABLE public.reservoir
(
  reservoir_id character varying(2),
  reservoir_name character varying(12),
  CONSTRAINT RESERVPK PRIMARY KEY (reservoir_id)
);

--Create table basin, primary key is basin_id
DROP TABLE IF EXISTS public.basin;
CREATE TABLE public.basin
(
  basin_id character varying(5),
  basin_name character varying(16),
  CONSTRAINT BASINPK PRIMARY KEY (basin_id)
);

--Create sequence for table project
DROP SEQUENCE IF EXISTS public.project_id_area_gid_seq;
CREATE SEQUENCE public.project_id_area_gid_seq START 1;

--Create table project, primary key is project_id
CREATE TABLE public.project
(
  project_id integer NOT NULL DEFAULT nextval('project_id_area_gid_seq'::regclass),
  project_name character varying(80),
  CONSTRAINT PROJECTPK PRIMARY KEY (project_id)
);

--Create table image, primary key is image_name, foreign key is project_no, referenced from project(project_id)
DROP TABLE IF EXISTS public.image;
CREATE TABLE public.image
(
  image_name character varying(80),
  image_date date,
  project_no integer,
  CONSTRAINT IMAGEPK PRIMARY KEY (image_name),
  CONSTRAINT IMAGEFK_ADMIN
    FOREIGN KEY (project_no) REFERENCES project(project_id)
);

--Create sequence for table slide_area
DROP SEQUENCE IF EXISTS public.slide_id_area_gid_seq;
CREATE SEQUENCE public.slide_id_area_gid_seq START 1; 

/*
Create table slide_area, primary key is (slide_id, image_no)
Foreign keys are (county_no, town_no), referenced from admin_area(county_id, town_id)
                 image_no, referenced from image(image_name)
                 workingcircle_no, referenced from working_circle(workingcircle_id)
                 reservoir_no, referenced from reservoir(reservoir_id)
                 water_no, referenced from watershed(water_id)
                 forest_no, referenced from forest_district(forest_id)
                 basin_no, referenced from basin(basin_id)*/
                 
CREATE TABLE public.slide_area
(
  slide_id integer NOT NULL DEFAULT nextval('slide_id_area_gid_seq'::regclass),
  centroid_x numeric,
  centroid_y numeric,
  area numeric,
  geom geometry(MultiPolygon,3826),
  image_no character varying(20),
  county_no character varying(5),
  town_no character varying(10),
  workingcircle_no character varying(2),
  reservoir_no character varying(12),
  water_no character varying(10),
  forest_no character varying(2),
  basin_no character varying(5),
  
  CONSTRAINT SLIDEPK 
    PRIMARY KEY (slide_id, image_no),
  CONSTRAINT SLIDEFK_ADMIN
    FOREIGN KEY (county_no, town_no) REFERENCES admin_area(county_id, town_id),    
  CONSTRAINT SLIDEFK_PHOTO
    FOREIGN KEY (image_no) REFERENCES image(image_name),
  CONSTRAINT SLIDEFK_WORK
    FOREIGN KEY (workingcircle_no) REFERENCES working_circle(workingcircle_id),
  CONSTRAINT SLIDEFK_RESERV
    FOREIGN KEY (reservoir_no) REFERENCES reservoir(reservoir_id),
  CONSTRAINT SLIDEFK_WATER    
    FOREIGN KEY (water_no) REFERENCES watershed(water_id),
  CONSTRAINT SLIDEFK_FOREST
    FOREIGN KEY (forest_no) REFERENCES forest_district(forest_id),
  CONSTRAINT SLIDEFK_BASIN
    FOREIGN KEY (basin_no) REFERENCES basin(basin_id)
);