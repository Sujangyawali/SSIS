DECLARE @CategoryFilter VARCHAR(100) = 'Electronics'  -- Example filter by category (can be passed dynamically)
DECLARE @RegionFilter VARCHAR(50) = 'North'  -- Example filter by region (can be passed dynamically)
DECLARE @SortColumn VARCHAR(50) = 'TXN_DT'  -- Example sort column (can be passed dynamically)
DECLARE @DynamicSQL NVARCHAR(MAX)

-- Constructing dynamic SQL
SET @DynamicSQL = N'
SELECT
    p.ProductCode,
    p.ProductName,
    s.SLS_RGN,
    SUM(s.F_SLS) AS TotalSales,
    COUNT(s.TXN_ID) AS TransactionCount
FROM 
    RDW_TGT.RDW_TGT_SALESTRANSACTION s
JOIN 
    RDW_TGT.RDW_TGT_PRODUCT p
ON 
    s.PRD_CDE = p.ProductCode
WHERE
    1 = 1'

-- Adding dynamic filters
IF @CategoryFilter IS NOT NULL
    SET @DynamicSQL = @DynamicSQL + ' AND s.PRD_CAT = @CategoryFilter'

IF @RegionFilter IS NOT NULL
    SET @DynamicSQL = @DynamicSQL + ' AND s.SLS_RGN = @RegionFilter'

-- Adding dynamic sorting
SET @DynamicSQL = @DynamicSQL + ' GROUP BY p.ProductCode, p.ProductName, s.SLS_RGN ORDER BY ' + @SortColumn

-- Executing the dynamic SQL
EXEC sp_executesql @DynamicSQL, N'@CategoryFilter VARCHAR(100), @RegionFilter VARCHAR(50)', @CategoryFilter, @RegionFilter;
