Landslide_Database
==========

Description
----------
###Author: Otakusaikou  
###Created: 2014/05/28  
###This repository provide the following functions:  
+ 1.  dbinit.sql: Initialize tables for landslide database.  
+ 2.  datain.sql: Upload processed result to database.  
+ 3.  queryall.sql: A test query for getting all valid landslide data in database.  
  

***
Update Log
----------
####2014-06-09 13:20
+ Init commit

***
####2014-06-10 09:35
+ 1.  queryall.sql: Update query command for new database structure.  

***
####2014-06-13 17:28
+ 1.  dbinit.sql, datain.sql: Bug fixed. Specify schema 'public' as target.  

***
####2014-06-15 21:20
+ 1.  dbinit.sql: 
  + Add NOT NULL attribute to all primary keys.  
  + Change project_name type to varchar(25) in table project.  
  + Change image_name type to varchar(25) in table image.  
  + Change image_no type to varchar(25) in table slide_area.  

***
####2014-06-28 03:10
+ 1.  dbinit.sql: Delete unused entry image.  
+ 2.  datain.sql: Algorithm modified.  
+ 3.  queryall.sql: Update query command for new database structure.  

***
####2014-07-04 04:35
+ 1.  dbinit.sql: Add handling for table ownership.  

***
####2014-07-10 12:28
+ 1.  datain.sql: Let the program delete result table after loading data to all tables.  

***
####2014-07-22 01:12
+ 1.  datain.sql: Let the program create template view by joining all tables together.
