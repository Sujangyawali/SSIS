CREATE PROCEDURE GetYearlySales
AS
BEGIN
   INSERT INTO RDW_DM.RDW_DM_SLS_YR_A (SaleYear, ProductCategory, ProductName, TotalUnitsSold, TotalSalesAmount)
    -- Step 1: Define the query for yearly sales
    SELECT 
        YEAR(TXN_DT) AS SaleYear, -- Extract year from SaleDate
        P.Category AS ProductCategory,           -- Category of the product
        P.ProductName AS ProductName,            -- Name of the product
        COUNT(S.PRD_CDE) AS TotalUnitsSold,  -- Total number of units sold
        SUM(F_SLS) AS TotalSalesAmount -- Total sales amount
    FROM 
        RDW_TGT.RDW_TGT_SALESTRANSACTION S
    INNER JOIN 
        RDW_TGT.RDW_TGT_PRODUCT P
    ON 
        S.PRD_CDE = P.ProductCode            -- Join based on ProductCode
    GROUP BY 
        YEAR(TXN_DT), 
        P.Category, 
        P.ProductName
    ORDER BY 
        SaleYear ASC, P.Category ASC, TotalSalesAmount DESC;
END;
GO