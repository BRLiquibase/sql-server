--liquibase formatted sql

--changeset benriley:test-seed-property runWith:sqlcmd
CREATE OR ALTER PROCEDURE dbo.TestRunWithC
AS
BEGIN
    SELECT 'Procedure C works' AS Result;
END
GO

EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Original description', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'TestRunWithC';
GO