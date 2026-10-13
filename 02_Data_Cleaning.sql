/*DATA CLEANING*/

-- CUSTOMER ID CLEANING

USE SalesAnalytics
GO

Select DISTINCT
    customer_id,
    customer_name
FROM dbo.Sales_Data
WHERE CUSTOMER_id IN ('Co-12640','Dl-13600','Dp-13240')


UPDATE dbo.Sales_Data
SET CUSTOMER_ID = UPPER(CUSTOMER_ID)
WHERE CUSTOMER_id IN ('Co-12640','Dl-13600','Dp-13240')

-- PRODUCT ID CHECK

SELECT
    product_id,
    COUNT(DISTINCT Product_Name) AS Number_of_Names
FROM dbo.sales_data
GROUP BY product_id
HAVING COUNT(DISTINCT Product_Name) > 1

SELECT DISTINCT
    Product_ID,
    Product_Name
FROM dbo.Sales_Data
WHERE Product_ID IN
(
    SELECT 
    product_id
FROM dbo.Sales_Data
GROUP BY product_id
HAVING COUNT(DISTINCT Product_Name) > 1
)

--Multiple Product IDs related to different product names, No Changes Made.

-- PRODUCT NAME CLEANING

SELECT
    PRODUCT_NAME
FROM dbo.Sales_Data
WHERE DATALENGTH(PRODUCT_NAME) > DATALENGTH(TRIM(PRODUCT_NAME)) 

UPDATE dbo.Sales_Data
SET PRODUCT_NAME = TRIM(PRODUCT_NAME)
WHERE DATALENGTH(PRODUCT_NAME) > DATALENGTH(TRIM(PRODUCT_NAME))

-- CHECK ZIP CODE LEN

SELECT
    Count(postal_code)
FROM dbo.Sales_Data
WHERE LEN(postal_code) < 5


SELECT
    Postal_Code,
    RIGHT('00000' + postal_code, 5) AS Test
FROM dbo.Sales_Data
WHERE LEN(postal_code) < 5


SELECT
    Column_Name,
    Data_type
FROM INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'Sales_Data' and
      COLUMN_NAME = 'Postal_Code'

ALTER TABLE dbo.Sales_Data
ALTER COLUMN Postal_Code VARCHAR(10)

UPDATE dbo.Sales_Data
SET Postal_Code = RIGHT('00000' + Postal_Code, 5)
WHERE LEN(postal_code) < 5

-- FINAL VALIDATION

SELECT
 SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END),
 SUM(CASE WHEN Product_name IS NULL THEN 1 ELSE 0 END),
 SUM(CASE WHEN Postal_Code IS NULL THEN 1 ELSE 0 END)
FROM dbo.Sales_Data


    
