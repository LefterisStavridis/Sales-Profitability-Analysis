/* Exploratory Data Analysis */

USE SalesAnalytics
GO

--Overall Business Performance--

SELECT
	SUM(SALES) as Total_Sales,
	SUM(PROFIT) AS Total_Profit,
	(SUM(PROFIT)/SUM(SALES)) * 100 AS Profit_Margin,
	COUNT(DISTINCT(ORDER_ID)) AS Total_Orders,
	SUM(SALES)/COUNT(DISTINCT(ORDER_ID)) AS Average_Order_Value
FROM dbo.Sales_Data

-- Performance Over Time --

SELECT
    YEAR,
    SUM(SALES) AS Total_Sales,
    SUM(PROFIT) AS Total_Profit,
    (SUM(PROFIT)/SUM(SALES)) * 100 AS Profit_Margin
FROM dbo.Sales_Data
GROUP BY YEAR
ORDER BY YEAR ASC

SELECT
	YEAR,
	Month,
	SUM(SALES) AS Total_Sales,
	SUM(PROFIT) AS Total_Profit,
	(SUM(PROFIT)/SUM(SALES)) * 100 AS Profit_Margin
FROM dbo.Sales_Data
GROUP BY YEAR,MONTH
ORDER BY YEAR,MIN(MONTH(Order_Date))	

/* Sales generally increased over the period, while monthly profitability showed considerable volatility.
Only two months generated an overall loss */

-- CATEGORY PERFORMANCE --

SELECT
	CATEGORY,
	SUM(SALES) AS Total_Sales,
	SUM(PROFIT) AS Total_Profit,
	(SUM(PROFIT)/SUM(SALES)) * 100 AS Profit_Margin
FROM dbo.Sales_Data
GROUP BY Category


SELECT
	CATEGORY,
	SUB_CATEGORY,
	SUM(SALES) AS Total_Sales,
	SUM(PROFIT) AS Total_Profit,
	(SUM(PROFIT)/SUM(SALES)) * 100 AS Profit_Margin
FROM dbo.Sales_Data
WHERE CATEGORY = 'FURNITURE'
GROUP BY Category,Sub_Category

/*Furniture was the least profitable category with
Bookcases and Tables generating negative profit */

--CHECK DISCOUNT AND PROFITABILITY--

SELECT
	CATEGORY,
	SUB_CATEGORY,
	SUM(SALES) AS Total_Sales,
	SUM(PROFIT) AS Total_Profit,
	(SUM(PROFIT)/SUM(SALES)) * 100 AS Profit_Margin,
	AVG(DISCOUNT) AS Average_Discount
FROM dbo.Sales_Data
WHERE CATEGORY = 'FURNITURE'
GROUP BY Category,Sub_Category


SELECT
	SUB_CATEGORY,
	Discount,
	SUM(SALES) AS Total_Sales,
	SUM(PROFIT) AS Total_Profit,
	(SUM(PROFIT)/SUM(SALES)) * 100 AS Profit_Margin
FROM dbo.Sales_Data
WHERE Sub_Category = 'Tables'
GROUP BY Sub_Category,Discount
ORDER BY Discount

-- Tables were profitable only at zero discount, all observed discount levels generated losses.--

--DISCOUNT ANALYSIS--

SELECT
	Discount,
	SUM(SALES) AS Total_Sales,
	SUM(PROFIT) AS Total_Profit,
	(SUM(PROFIT)/SUM(SALES)) * 100 AS Profit_Margin,
	COUNT(*) as Transaction_Rows
FROM dbo.Sales_Data
GROUP BY Discount
ORDER BY Discount

-- Higher discounts are associated with lower profitability, discounts of 30% and above generate aggregate losses--

-- Segment Performance --

SELECT
	SEGMENT,
	SUM(SALES) AS Total_Sales,
	SUM(PROFIT) AS Total_Profit,
	(SUM(PROFIT)/SUM(SALES)) * 100 AS Profit_Margin,
	AVG(DISCOUNT) AS Average_Discount
FROM dbo.Sales_Data
GROUP BY Segment

/* Consumer leads in sales and profit but has the lowest profit margin.
All segments have similar average discounts. */

-- GEOGRAPHIC PERFORMANCE --

SELECT
	Region,
	SUM(SALES) AS Total_Sales,
	SUM(PROFIT) AS Total_Profit,
	(SUM(PROFIT)/SUM(SALES)) * 100 AS Profit_Margin
FROM dbo.Sales_Data
GROUP BY Region


SELECT
	State,
	SUM(SALES) AS Total_Sales,
	SUM(PROFIT) AS Total_Profit,
	(SUM(PROFIT)/SUM(SALES)) * 100 AS Profit_Margin
FROM dbo.Sales_Data
WHERE REGION = 'CENTRAL'
GROUP BY State

--Central has the lowest regional profit margin, driven primarily by Illinois and Texas.--

SELECT
	State,
	SUM(SALES) AS Total_Sales,
	SUM(PROFIT) AS Total_Profit,
	(SUM(PROFIT)/SUM(SALES)) * 100 AS Profit_Margin,
	AVG(DISCOUNT) AS Average_Discount
FROM dbo.Sales_Data
WHERE REGION = 'CENTRAL'
GROUP BY State


/*Illinois and Texas have the highest average discounts and negative profitability*/


-- CUSTOMER ANALYSIS --


--Top 10 Customers by Sales and Profitability--


SELECT TOP 10
	CUSTOMER_ID,
	CUSTOMER_NAME,
	SUM(SALES) AS Total_Sales,
	SUM(PROFIT) AS Total_Profit,
	(SUM(PROFIT)/SUM(SALES)) * 100 AS Profit_Margin
FROM dbo.Sales_Data
Group by Customer_ID,Customer_Name
ORDER BY Total_Sales DESC

-- High customer sales do not necessarily translate to high profitability, highest sales customer is loss making.--

SELECT
	Discount,
	SUM(SALES) AS Total_Sales,
	SUM(PROFIT) AS Total_Profit,
	(SUM(PROFIT)/SUM(SALES)) * 100 AS Profit_Margin
FROM dbo.Sales_Data
WHERE Customer_ID = 'SM-20320'
GROUP BY Discount
ORDER BY Discount

/* Highest-Sales Customer is loss making, the majority of his sales occurred at a 50% discount
where profitability was negative */

--Lowest Profit Customers--

SELECT TOP 10
	CUSTOMER_ID,
	CUSTOMER_NAME,
	SUM(SALES) AS Total_Sales,
	SUM(PROFIT) AS Total_Profit,
	(SUM(PROFIT)/SUM(SALES)) * 100 AS Profit_Margin
FROM dbo.Sales_Data
Group by Customer_ID,Customer_Name
ORDER BY Total_Profit ASC


SELECT
	Discount,
	SUM(SALES) AS Total_Sales,
	SUM(PROFIT) AS Total_Profit,
	(SUM(PROFIT)/SUM(SALES)) * 100 AS Profit_Margin
FROM dbo.Sales_Data
WHERE Customer_ID = 'CS-12505'
GROUP BY Discount
ORDER BY Discount

-- Cindy Stewart's losses are concentrated at a 70% discount--

--Shipping Analysis--

SELECT
	Ship_Mode,
	SUM(SALES) AS Total_Sales,
	AVG(CONVERT(DECIMAL(10,2),SHIPPING_DAYS)) AS Average_Shipping_Days,
	SUM(PROFIT) AS Total_Profit,
	(SUM(PROFIT)/SUM(SALES)) * 100 AS Profit_Margin
FROM dbo.Sales_Data
GROUP BY Ship_Mode

-- Shipping modes differ in average shipping days,but show similar profit margins.--















	