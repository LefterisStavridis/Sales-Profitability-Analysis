/*Data Validation*/

USE SalesAnalytics
GO

-- Ιnitial data profiling

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT Order_ID) AS Unique_Orders,
    COUNT(DISTINCT Customer_ID) AS Unique_Customers,
    COUNT(DISTINCT Product_ID) AS Unique_Products,
    COUNT(DISTINCT Category) AS Categories,
    COUNT(DISTINCT Sub_Category) AS Sub_Categories,
    COUNT(DISTINCT State) AS States,
    COUNT(DISTINCT Region) AS Regions
FROM dbo.Sales_Data;


-- Null Checks
   
SELECT
    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS Sales_Nulls,
    SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS Profit_Nulls,
    SUM(CASE WHEN Profit_Margin IS NULL THEN 1 ELSE 0 END) AS Profit_Margin_Nulls
FROM dbo.Sales_Data;



-- Range Tests

SELECT
    MIN(Order_Date) AS Min_Order_Date,
    MAX(Order_Date) AS Max_Order_Date,
    MIN(Ship_Date) AS Min_Ship_Date,
    MAX(Ship_Date) AS Max_Ship_Date,

    MIN(Sales) AS Min_Sales,
    MAX(Sales) AS Max_Sales,

    MIN(Quantity) AS Min_Quantity,
    MAX(Quantity) AS Max_Quantity,

    MIN(Discount) AS Min_Discount,
    MAX(Discount) AS Max_Discount,

    MIN(Profit) AS Min_Profit,
    MAX(Profit) AS Max_Profit,

    MIN(Profit_Margin) AS Min_Profit_Margin,
    MAX(Profit_Margin) AS Max_Profit_Margin,

    MIN(Shipping_Days) AS Min_Shipping_Days,
    MAX(Shipping_Days) AS Max_Shipping_Days
FROM dbo.Sales_Data;

--Row_ID Duplicates

SELECT
    Row_ID,
    COUNT(*) AS Duplicate_Count
FROM dbo.Sales_Data
GROUP BY Row_ID
HAVING COUNT(*) > 1

--Look for identical records, without Row_ID

SELECT
    Order_ID,
    Order_Date,
    Ship_Date,
    Ship_Mode,
    Customer_ID,
    Customer_Name,
    Segment,
    City,
    State,
    Postal_Code,
    Region,
    Product_ID,
    Category,
    Sub_Category,
    Product_Name,
    Sales,
    Quantity,
    Discount,
    Profit,
    Profit_Margin,
    Shipping_Days,
    Year,
    Month,
    COUNT(*)
FROM dbo.Sales_Data
GROUP BY
    Order_ID,
    Order_Date,
    Ship_Date,
    Ship_Mode,
    Customer_ID,
    Customer_Name,
    Segment,
    City,
    State,
    Postal_Code,
    Region,
    Product_ID,
    Category,
    Sub_Category,
    Product_Name,
    Sales,
    Quantity,
    Discount,
    Profit,
    Profit_Margin,
    Shipping_Days,
    Year,
    Month
HAVING COUNT(*) > 1;

