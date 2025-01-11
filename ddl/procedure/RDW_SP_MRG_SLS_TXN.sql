CREATE PROCEDURE RDW_SP_MRG_SLS_TXN
AS
BEGIN
    SET NOCOUNT ON;

    MERGE RDW_TGT.RDW_TGT_SALESTRANSACTION AS TARGET
    USING RDW_TMP.RDW_TMP_SALESTRANSACTION AS SOURCE
    ON TARGET.TXN_ID = SOURCE.TXN_ID
    WHEN MATCHED THEN
        UPDATE SET 
            TARGET.CUS_FUL_NAME = SOURCE.CUS_FUL_NAME,
            TARGET.TXN_DT = SOURCE.TXN_DT,
            TARGET.PRD_CDE = SOURCE.PRD_CDE,
            TARGET.F_QTY = SOURCE.F_QTY,
            TARGET.F_SLS = SOURCE.F_SLS,
            TARGET.F_TAX = SOURCE.F_TAX,
            TARGET.PRD_CAT = SOURCE.PRD_CAT,
            TARGET.SLS_RGN = SOURCE.SLS_RGN,
            TARGET.TXN_STTUS = SOURCE.TXN_STTUS,
            TARGET.RECORD_UPDATE_TIMESTAMP = GETDATE()
    WHEN NOT MATCHED BY TARGET THEN
        INSERT (
            TXN_ID, 
            CUS_FUL_NAME, 
            TXN_DT, 
            PRD_CDE, 
            F_QTY, 
            F_SLS, 
            F_TAX, 
            PRD_CAT, 
            SLS_RGN, 
            TXN_STTUS, 
            RECORD_INSERT_TIMESTAMP,
            RECORD_UPDATE_TIMESTAMP
        )
        VALUES (
            SOURCE.TXN_ID,
            SOURCE.CUS_FUL_NAME,
            SOURCE.TXN_DT,
            SOURCE.PRD_CDE,
            SOURCE.F_QTY,
            SOURCE.F_SLS,
            SOURCE.F_TAX,
            SOURCE.PRD_CAT,
            SOURCE.SLS_RGN,
            SOURCE.TXN_STTUS,
            GETDATE(),
            GETDATE()
        );
END;
