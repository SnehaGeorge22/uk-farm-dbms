#---------------------------------------------------------------------------------------------------------------#
# Command for Creating a database named "farms"
create database farms;

#---------------------------------------------------------------------------------------------------------------#

# Command for using the newly created database "farms"
use farms;

#----------------------------------Adding all the drop statements before creating tables------------------------#
#---------------farm_details drop statement is added after all drop statements to avoid Error 3730--------------#
#---------------------------------------------------------------------------------------------------------------#
# Command for dropping the table "sustainability_details" if already exists in database
drop table if exists sustainability_details;

#---------------------------------------------------------------------------------------------------------------#
# Command for dropping the table "soil_health_metrics" if already exists in database
drop table if exists soil_health_metrics;

#---------------------------------------------------------------------------------------------------------------#
# Command for dropping the table "water_source_details" if already exists in database
drop table if exists water_source_details;

#---------------------------------------------------------------------------------------------------------------#
# Command for dropping the table "resource_usage_details" if already exists in database
drop table if exists resource_usage_details;

#---------------------------------------------------------------------------------------------------------------#
# Command for dropping the table "resource_details" if already exists in database
drop table if exists resource_details;

#---------------------------------------------------------------------------------------------------------------#
# Command for dropping the table "crop_details" if already exists in database
drop table if exists crop_details;

#---------------------------------------------------------------------------------------------------------------#
# Command for dropping the table "farm_details" if already exists in database
drop table if exists farm_details;

#---------------------------------------------------------------------------------------------------------------#

# DDL for the table "farm_details"
# Adding auto_increment constraint to the primary key since test data in farm_id column is continuous

create table farm_details (
farm_id int not null auto_increment primary key,
farm_name varchar(255) default (' '),
farm_location varchar(255) NOT NULL default (' '),
index farm_id_idx (farm_id)
)engine=InnoDB;

#---------------------------------------------------------------------------------------------------------------#

# DDL for the table "crop_details"
# Auto_increment is not added to primary key since test data in crop_id column is not continous
create table crop_details (
crop_id int not null primary key check (crop_id > 0),
crop_name varchar(255) not null DEFAULT (' '),
planting_date date DEFAULT (current_date),
harvest_date date DEFAULT (current_date),
crop_yield int DEFAULT (0),
farm_id int,
foreign key (farm_id) references farm_details (farm_id),
index crop_id_idx (crop_id)
)engine=InnoDB;

#---------------------------------------------------------------------------------------------------------------#

# DDL for the table "soil_health_metrics"
# Adding auto_increment constraint to the primary key since test data in soil_id column is continuous
create table soil_health_metrics (
soil_id int not null auto_increment primary key,
ph_level float default (0.0),
nitrogen_level int default (0),
phosphorus_level int default (0),
potassium_level int default (0),
farm_id int not null,
foreign key (farm_id) references farm_details (farm_id),
index soil_id_idx (soil_id)
)engine=InnoDB;

#---------------------------------------------------------------------------------------------------------------#
# DDL for the table "sustainability_details"
# Adding auto_increment constraint to the primary key since test data in sustain_init_id column is continuous
create table sustainability_details (
sustain_init_id int not null auto_increment primary key,
sustain_init_desc varchar(255) default (' '),
sustain_init_date date default (current_date()),
expected_impact varchar(255) default (' '),
environ_impact_score int default (0),
farm_id int not null,
foreign key (farm_id) references farm_details (farm_id),
index sustain_init_id_idx (sustain_init_id)
)engine=InnoDB;

#---------------------------------------------------------------------------------------------------------------#
# DDL for the table "resource_details"
# Adding auto_increment constraint to the primary key since test data in resource_id column is continuous
create table resource_details (
resource_id int not null auto_increment primary key,
resource_name varchar(255) default (' '),
index rsrc_id_idx (resource_id)
)engine=InnoDB;

#---------------------------------------------------------------------------------------------------------------#
# DDL for the table "resource_usage_details"
# Adding auto_increment constraint to the primary key since test data in res_usage_id column is continuous
create table resource_usage_details (
res_usage_id int not null auto_increment primary key,
res_quantity_used int default (0),
res_application_date date default (current_date()),
labour_hours_used int default (0),
resource_id int not null,
crop_id int not null,
farm_id int not null,
foreign key (resource_id) references resource_details (resource_id),
foreign key (crop_id) references crop_details (crop_id),
foreign key (farm_id) references farm_details (farm_id),
index res_usage_idx (res_usage_id)
)engine=InnoDB;

#---------------------------------------------------------------------------------------------------------------#
# DDL for the table "water_source_details"
# Adding auto_increment constraint to the primary key since test data in source_id column is continuous
create table water_source_details (
source_id int not null auto_increment primary key,
source_name varchar(255) default (' '),
farm_id int not null,
foreign key (farm_id) references farm_details (farm_id),
index src_id_idx (source_id)
)engine=InnoDB;

#---------------------------------------------------------------------------------------------------------------#
# DDL for the view "farm_dtl_vw"
create or replace view farm_dtl_vw as
select  farm_id,
farm_name,
farm_location
from farms.farm_details;


#---------------------------------------------------------------------------------------------------------------#
# DDL for the view "crop_dtls_vw"
create or replace view crop_dtls_vw as 
select crop_id,
crop_name,
planting_date,
harvest_date,
crop_yield,
farm_id
from crop_details;

#---------------------------------------------------------------------------------------------------------------#
# DDL for the view "soil_metrics_vw"
create or replace view soil_metrics_vw as
select soil_id,
ph_level,
nitrogen_level,
phosphorus_level,
potassium_level,
farm_id 
from soil_health_metrics;

#---------------------------------------------------------------------------------------------------------------#

# DDL for the view "sustain_dtls_vw"
create or replace view sustain_dtls_vw as
select sustain_init_id,
sustain_init_desc,
sustain_init_date,
expected_impact,
environ_impact_score,
farm_id
from 
sustainability_details;

#---------------------------------------------------------------------------------------------------------------#

# DDL for the view "vw"
create or replace view resource_dtls_vw as 
select resource_id, resource_name from resource_details;

#---------------------------------------------------------------------------------------------------------------#

# DDL for the view "resource_usage_dtls_vw"
create or replace view resource_usage_dtls_vw as 
select 
res_usage_id,
res_quantity_used,
res_application_date,
labour_hours_used,
resource_id,
crop_id,
farm_id
from resource_usage_details;

#---------------------------------------------------------------------------------------------------------------#

# DDL for the view "water_src_dtls_vw"
create or replace view water_src_dtls_vw as 
select source_id,source_name,farm_id from water_source_details;

#---------------------------------------------------------------------------------------------------------------#
# Inserting test data into farm_details 

insert into farm_details (farm_name,farm_location) values ("South Farm","Kent");
insert into farm_details (farm_name,farm_location) values ("Green Acres","Essex");
insert into farm_details (farm_name,farm_location) values ("Sunny Fields","Hampshire");
insert into farm_details (farm_name,farm_location) values ("Hilltop Farm","Yorkshire");
insert into farm_details (farm_name,farm_location) values ("Riverbend Farm","Cornwall");

#---------------------------------------------------------------------------------------------------------------#
# Inserting test data into crop_details table
insert into crop_details (crop_id,crop_name,planting_date,harvest_date,crop_yield,farm_id) 
values (101,"Wheat","2023-03-15","2023-08-15",3000,1);
insert into crop_details (crop_id,crop_name,planting_date,harvest_date,crop_yield,farm_id) 
values (102,"Barley","2023-03-16","2023-08-20",2800,1);
insert into crop_details (crop_id,crop_name,planting_date,harvest_date,crop_yield,farm_id) 
values (201,"Corn","2023-04-10","2023-09-15",1500,2);
insert into crop_details (crop_id,crop_name,planting_date,harvest_date,crop_yield,farm_id) 
values (202,"Soybeans","2023-04-11","2023-09-20",1200,2);
insert into crop_details (crop_id,crop_name,planting_date,harvest_date,crop_yield,farm_id) 
values (301,"Potatoes","2023-03-20","2023-07-15",2000,3);
insert into crop_details (crop_id,crop_name,planting_date,harvest_date,crop_yield,farm_id) 
values (302,"Carrots","2023-03-21","2023-07-20",2200,3);
insert into crop_details (crop_id,crop_name,planting_date,harvest_date,crop_yield,farm_id) 
values (401,"Apples","2023-04-05","2023-09-10",1800,4);
insert into crop_details (crop_id,crop_name,planting_date,harvest_date,crop_yield,farm_id) 
values (402,"Pears","2023-04-06","2023-09-15",1600,4);
insert into crop_details (crop_id,crop_name,planting_date,harvest_date,crop_yield,farm_id) 
values (501,"Tomatoes","2023-03-25","2023-08-10",2500,5);
insert into crop_details (crop_id,crop_name,planting_date,harvest_date,crop_yield,farm_id) 
values (502,"Lettuce","2023-03-26","2023-08-15",2400,5);

#---------------------------------------------------------------------------------------------------------------#
# Inserting test data into soil_health_metrics table
insert into soil_health_metrics (ph_level,nitrogen_level,phosphorus_level,potassium_level,farm_id) 
values (6.5,50,20,180,1);
insert into soil_health_metrics (ph_level,nitrogen_level,phosphorus_level,potassium_level,farm_id) 
values (6.8,40,25,160,2);
insert into soil_health_metrics (ph_level,nitrogen_level,phosphorus_level,potassium_level,farm_id) 
values (6.2,30,15,150,3);
insert into soil_health_metrics (ph_level,nitrogen_level,phosphorus_level,potassium_level,farm_id) 
values (6.4,45,22,175,4);
insert into soil_health_metrics (ph_level,nitrogen_level,phosphorus_level,potassium_level,farm_id) 
values (6.7,55,28,200,5);

#---------------------------------------------------------------------------------------------------------------#
# Inserting test data into sustainability_details table
insert into sustainability_details (sustain_init_desc,sustain_init_date,expected_impact,environ_impact_score,farm_id) 
values ("Organic Farming","2023-01-01","Increase in yield",4,1);
insert into sustainability_details (sustain_init_desc,sustain_init_date,expected_impact,environ_impact_score,farm_id) 
values ("Crop Rotation","2023-02-15","Improved soil quality",3,2);
insert into sustainability_details (sustain_init_desc,sustain_init_date,expected_impact,environ_impact_score,farm_id) 
values ("Water Conservation","2023-03-01","Reduced water usage",5,3);
insert into sustainability_details (sustain_init_desc,sustain_init_date,expected_impact,environ_impact_score,farm_id) 
values ("Soil Health Improvement","2023-01-20","Enhanced nutrient retention",2,4);
insert into sustainability_details (sustain_init_desc,sustain_init_date,expected_impact,environ_impact_score,farm_id) 
values ("Pesticide Reduction","2023-02-10","Less chemical runoff",4,5);

#---------------------------------------------------------------------------------------------------------------#
# Inserting test data into resource_details table
insert into resource_details (resource_name) values ("Water");
insert into resource_details (resource_name) values ("Fertilizer");

#---------------------------------------------------------------------------------------------------------------#
# Inserting test data into resource_usage_details table
insert into resource_usage_details (res_quantity_used,res_application_date,labour_hours_used,resource_id,crop_id,farm_id)
values (1000,"2023-03-10",150,1,101,1);
insert into resource_usage_details (res_quantity_used,res_application_date,labour_hours_used,resource_id,crop_id,farm_id)
values (200,"2023-03-12",120,2,102,1);
insert into resource_usage_details (res_quantity_used,res_application_date,labour_hours_used,resource_id,crop_id,farm_id)
values (800,"2023-04-05",200,1,201,2);
insert into resource_usage_details (res_quantity_used,res_application_date,labour_hours_used,resource_id,crop_id,farm_id)
values (150,"2023-04-06",180,2,202,2);
insert into resource_usage_details (res_quantity_used,res_application_date,labour_hours_used,resource_id,crop_id,farm_id)
values (1200,"2023-03-18",160,1,301,3);
insert into resource_usage_details (res_quantity_used,res_application_date,labour_hours_used,resource_id,crop_id,farm_id)
values (300,"2023-03-19",170,2,302,3);
insert into resource_usage_details (res_quantity_used,res_application_date,labour_hours_used,resource_id,crop_id,farm_id)
values (900,"2023-04-02",140,1,401,4);
insert into resource_usage_details (res_quantity_used,res_application_date,labour_hours_used,resource_id,crop_id,farm_id)
values (250,"2023-04-03",130,2,402,4);
insert into resource_usage_details (res_quantity_used,res_application_date,labour_hours_used,resource_id,crop_id,farm_id)
values (1100,"2023-03-22",190,1,501,5);
insert into resource_usage_details (res_quantity_used,res_application_date,labour_hours_used,resource_id,crop_id,farm_id)
values (180,"2023-03-24",175,2,502,5);

#---------------------------------------------------------------------------------------------------------------#
# Inserting test data into water_source_details table
insert into water_source_details (source_name,farm_id) values ("River",1);
insert into water_source_details (source_name,farm_id) values ("Borehole",2);
insert into water_source_details (source_name,farm_id) values ("Rainwater",3);
insert into water_source_details (source_name,farm_id) values ("Well",4);
insert into water_source_details (source_name,farm_id) values ("River",5);

#---------------------------------------------------------------------------------------------------------------#
# Commiting the changes 
commit;
#---------------------------------------------------------------------------------------------------------------#
# Using select statement to view the test data
select * from farm_dtl_vw;
select * from crop_dtls_vw;
select * from soil_metrics_vw;
select * from sustain_dtls_vw;
select * from resource_dtls_vw;
select * from resource_usage_dtls_vw;
select * from water_src_dtls_vw;

#---------------------------------------------------------------------------------------------------------------#
#viewing indexes for farm_details table
show indexes from farm_details;
#---------------------------------------------------------------------------------------------------------------#