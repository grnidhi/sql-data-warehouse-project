/*
================================================
Create Database and Schemas
================================================

Script Purpose:
This script creates a new database named 'DataWareHouse' after checking if it already exists.
If the dB exists,it is dropped and recreated.Additionally,the script sets up three schemas within
the database : 'bronze','silver',and gold.

Warning:
 Running this script will drop the entire 'DataWareHouse' database if it exists.
 All data in the database will be permanently deleted.Proceed with caution and
 ensure you have proper backups before running this script

*/

use master;
go

--drop and recreate the 'datawarehouse' database

if exists(select 1 from sys.databases where name = 'DataWareHouse')
Begin
	Alter Database DataWareHouse Set SINGLE_USER WITH ROLLBACK IMMEDIATE;
	Drop database DataWareHouse;
end;
go

--create the 'datawarehouse' database
create database DataWareHouse;
go

use DataWareHouse;
go

--create schemas

create schema bronze;
go

create schema silver;
go

create schema gold;
go
