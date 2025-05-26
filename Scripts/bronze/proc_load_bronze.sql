/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/


CREATE OR ALTER PROCEDURE Bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '=========================================================================================================================';
		PRINT 'Loading Bronze Layer ';
		PRINT '=========================================================================================================================';

		PRINT '--------------------------------------------------------------------------------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '--------------------------------------------------------------------------------------------------------------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: Bronze.crm_cust_info';
		TRUNCATE TABLE Bronze.crm_cust_info

		Print '>> Inserting Data Into: Bronze.crm_cust_info';
		BULK INSERT Bronze.crm_cust_info
		from 'A:\sql-ultimate-course\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> ------------';


		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: Bronze.crm_prd_info';
		TRUNCATE TABLE Bronze.crm_prd_info

		Print '>> Inserting Data Into: Bronze.crm_prd_info';
		BULK INSERT Bronze.crm_prd_info
		from 'A:\sql-ultimate-course\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> ------------';


		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: Bronze.crm_sales_details';
		TRUNCATE TABLE Bronze.crm_sales_details

		Print '>> Inserting Data Into: Bronze.crm_sales_details';
		BULK INSERT Bronze.crm_sales_details
		from 'A:\sql-ultimate-course\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> ------------';


		Print '--------------------------------------------------------------------------------------------------------------------------';
		PRINT 'Loading ERP Tables';
		Print '--------------------------------------------------------------------------------------------------------------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: Bronze.erp_cust_az12';
		TRUNCATE TABLE Bronze.erp_cust_az12

		Print '>> Inserting Data Into: Bronze.erp_cust_az12';
		BULK INSERT Bronze.erp_cust_az12
		from 'A:\sql-ultimate-course\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> ------------';


		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: Bronze.erp_loc_a101';
		TRUNCATE TABLE Bronze.erp_loc_a101

		Print '>> Inserting Data Into: Bronze.erp_loc_a101';
		BULK INSERT Bronze.erp_loc_a101
		from 'A:\sql-ultimate-course\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> ------------';


		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: Bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE Bronze.erp_px_cat_g1v2

		Print '>> Inserting Data Into: Bronze.erp_px_cat_g1v2';
		BULK INSERT Bronze.erp_px_cat_g1v2
		from 'A:\sql-ultimate-course\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> ------------';

		SET @batch_end_time = GETDATE();
		PRINT '>> Loading Bronze Layer is Completed';
		PRINT '>> - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds';
		PRINT '============================================='
	END TRY
	BEGIN CATCH
		PRINT '=========================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR MESSAGE' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================';
	END CATCH
END
