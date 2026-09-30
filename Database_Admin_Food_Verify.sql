USE CraveCoFoodOrderingDB;
GO

/* Verify that the admin insert target exists and has the required columns. */
IF OBJECT_ID('dbo.FoodItems','U') IS NULL
BEGIN
    RAISERROR('FoodItems table is missing. Run Database.sql first.', 16, 1);
    RETURN;
END
GO

SELECT
    FoodId, FoodName, Description, Category, Price, ImageUrl, IsAvailable
FROM dbo.FoodItems
ORDER BY FoodId DESC;
GO
