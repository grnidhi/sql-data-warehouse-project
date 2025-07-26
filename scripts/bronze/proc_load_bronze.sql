/*
================================================================
stored procedure :load bronze layer(source -> bronze)
================================================================
Script Purpose:
This stored procedire loads data into the 'bronze' schema from external csv files.
It performs the following actions:
-Truncates the bronze tables before loading data.
-Uses the 'BULK INSERT' command to load data from csv Files to bronze tables.

Parameter:
none
this stores procedure does not accept any parameter or return any values.

Usage Examplle:
ECEX bronze.load_bronze;

=======================================================================
*/


use DataWareHouse
go
create or alter procedure bronze.load_bronze as 
begin
	declare @start_time datetime,@end_time datetime;
	begin try

	
		print '=========================================';
		print 'loading the bronze layer';
		print '=========================================';

		print'----------------------------------------';
		print 'loading crm tables';
		print'----------------------------------------';
		
		set @start_time =GETDATE();
		truncate table bronze.crm_cust_info;

		BULK INSERT bronze.crm_cust_info
		from 'C:\SQL course udemy\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
		firstrow=2,
		fieldterminator = ',',
		tablock
		);
			set @end_time =GETDATE();

		truncate table bronze.crm_prd_info;

		BULK INSERT bronze.crm_prd_info
		from 'C:\SQL course udemy\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
		firstrow=2,
		fieldterminator = ',',
		tablock
		);

		truncate table bronze.crm_sales_details;

		BULK INSERT bronze.crm_sales_details
		from 'C:\SQL course udemy\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
		firstrow=2,
		fieldterminator = ',',
		tablock
		);

	
		print'----------------------------------------';
		print 'loading erp tables';
		print'----------------------------------------';

		truncate table bronze.erp_loc_a101;

		BULK INSERT bronze.erp_loc_a101
		from 'C:\SQL course udemy\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		with (
		firstrow=2,
		fieldterminator = ',',
		tablock
		);


		truncate table bronze.erp_cust_az12;

		BULK INSERT bronze.erp_cust_az12
		from 'C:\SQL course udemy\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		with (
		firstrow=2,
		fieldterminator = ',',
		tablock
		);

		truncate table bronze.erp_px_cat_g1v2;

		BULK INSERT bronze.erp_px_cat_g1v2
		from 'C:\SQL course udemy\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		with (
		firstrow=2,
		fieldterminator = ',',
		tablock
		);

	end try

	begin catch
		print'=============='
		print'error occured during loading bronze layer'
		print'error message'+ error_message();
		print'error message'+ cast(error_number() as nvarchar);
		print'error message'+ cast(error_state() as nvarchar)
		print'=============='
	end catch

end
