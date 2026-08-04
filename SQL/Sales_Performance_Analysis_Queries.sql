/*=============================================================
Sales Performance & Financial Analysis Dashboard
Analysis Queries
=============================================================*/

---------------------------------------------------------------
1. Monthly Sales & Profit Trend
---------------------------------------------------------------

SELECT
    Year(Orders.OrderDate) AS SalesYear,
    Month(Orders.OrderDate) AS SalesMonth,
    DateSerial (
        Year(Orders.OrderDate),
        Month(Orders.OrderDate),
        1
    ) AS MonthStart,
    Sum(OrderDetails.Sales) AS TotalSales,
    Sum(OrderDetails.Profit) AS TotalProfit
FROM
    Orders
    INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY
    Year(Orders.OrderDate),
    Month(Orders.OrderDate),
    DateSerial (
        Year(Orders.OrderDate),
        Month(Orders.OrderDate),
        1
    )
ORDER BY
    Year(Orders.OrderDate),
    Month(Orders.OrderDate);

---------------------------------------------------------------
2. KPI - Total Sales
---------------------------------------------------------------

SELECT
    Sum(Sales) AS TotalSales
FROM
    OrderDetails;

---------------------------------------------------------------
3. KPI - Total Profit
---------------------------------------------------------------

SELECT
    Sum(Profit) AS TotalProfit
FROM
    OrderDetails;

---------------------------------------------------------------
4. KPI - Profit Margin
---------------------------------------------------------------

SELECT
    IIf(
        Sum([OrderDetails].[Sales]) = 0,
        0,
        Sum([OrderDetails].[Profit]) / Sum([OrderDetails].[Sales])
    ) AS ProfitMargin
FROM
    OrderDetails;

---------------------------------------------------------------
5. Sales by Category
---------------------------------------------------------------

SELECT
    Products.Category,
    SUM(OrderDetails.Sales) AS TotalSales
FROM
    Products
    INNER JOIN OrderDetails ON Products.ProductKey = OrderDetails.ProductKey
GROUP BY
    Products.Category
ORDER BY
    SUM(OrderDetails.Sales) DESC;

---------------------------------------------------------------
6. Profit by Category
---------------------------------------------------------------

SELECT
    Products.Category,
    SUM(OrderDetails.Profit) AS TotalProfit
FROM
    Products
    INNER JOIN OrderDetails ON Products.ProductKey = OrderDetails.ProductKey
GROUP BY
    Products.Category
ORDER BY
    SUM(OrderDetails.Profit) DESC;

---------------------------------------------------------------
7. Sales by Region
---------------------------------------------------------------

SELECT
    Orders.Region,
    SUM(OrderDetails.Sales) AS TotalSales
FROM
    Orders
    INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY
    Orders.Region
ORDER BY
    SUM(OrderDetails.Sales) DESC;

---------------------------------------------------------------
8. Profit by Region
---------------------------------------------------------------

SELECT
    Orders.Region,
    SUM(OrderDetails.Profit) AS TotalProfit
FROM
    Orders
    INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY
    Orders.Region
ORDER BY
    SUM(OrderDetails.Profit) DESC;

---------------------------------------------------------------
9. Sales by Product
---------------------------------------------------------------

SELECT
    Products.ProductName,
    SUM(OrderDetails.Sales) AS TotalSales
FROM
    Products
    INNER JOIN OrderDetails ON Products.ProductKey = OrderDetails.ProductKey
GROUP BY
    Products.ProductName
ORDER BY
    SUM(OrderDetails.Sales) DESC;

---------------------------------------------------------------
10. Profit by Product
---------------------------------------------------------------

SELECT
    Products.ProductName,
    SUM(OrderDetails.Profit) AS TotalProfit
FROM
    Products
    INNER JOIN OrderDetails ON Products.ProductKey = OrderDetails.ProductKey
GROUP BY
    Products.ProductName
ORDER BY
    SUM(OrderDetails.Profit) DESC;

---------------------------------------------------------------
11. KPI - Average Shipping Days
---------------------------------------------------------------

SELECT
    Avg(DateDiff("d", [OrderDate], [ShipDate])) AS AvgShippingDays
FROM
    Orders;

---------------------------------------------------------------
12. KPI - Average Order Value
---------------------------------------------------------------

SELECT
    KPI_TotalSales.TotalSales / KPI_TotalOrders.TotalOrders AS AverageOrderValue
FROM
    KPI_TotalSales,
    KPI_TotalOrders;

---------------------------------------------------------------
13. Top 10 Customers
---------------------------------------------------------------

SELECT
    TOP 10 Customers.CustomerName,
    SUM(OrderDetails.Sales) AS TotalSales
FROM
    (
        Customers
        INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
    )
    INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY
    Customers.CustomerName
ORDER BY
    SUM(OrderDetails.Sales) DESC;