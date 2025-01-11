CREATE PROCEDURE RDW_SP_MRG_PRD
AS
BEGIN
    SET NOCOUNT ON;

    MERGE RDW_TGT.RDW_TGT_PRODUCT AS TARGET
    USING RDW_TMP.RDW_TMP_PRODUCT AS SOURCE
    ON TARGET.ProductCode = SOURCE.ProductCode
    WHEN MATCHED THEN
        UPDATE SET 
            TARGET.ProductName = SOURCE.ProductName,
            TARGET.Category = SOURCE.Category,
            TARGET.Price = SOURCE.Price,
            TARGET.RECORD_UPDATE_TIMESTAMP = GETDATE()
    WHEN NOT MATCHED BY TARGET THEN
        INSERT (
            ProductCode, 
            ProductName, 
            Category, 
            Price, 
            RECORD_INSERT_TIMESTAMP,
            RECORD_UPDATE_TIMESTAMP
        )
        VALUES (
            SOURCE.ProductCode,
            SOURCE.ProductName,
            SOURCE.Category,
            SOURCE.Price,
            GETDATE(),
            GETDATE() 
        );
END;
