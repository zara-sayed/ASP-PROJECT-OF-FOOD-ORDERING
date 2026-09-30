USE CraveCoFoodOrderingDB;
GO

IF COL_LENGTH('dbo.Orders','PaymentReference') IS NULL
BEGIN
    ALTER TABLE dbo.Orders ADD PaymentReference NVARCHAR(200) NULL;
END
GO

-- Verify that the order detail table has the quantity/subtotal fields required by checkout.
IF COL_LENGTH('dbo.OrderDetails','Quantity') IS NULL
BEGIN
    ALTER TABLE dbo.OrderDetails ADD Quantity INT NOT NULL CONSTRAINT DF_OrderDetails_Quantity DEFAULT 1;
END
GO

SELECT TOP 10 OrderId, PaymentMethod, PaymentReference, TotalAmount, OrderStatus, OrderDate
FROM dbo.Orders
ORDER BY OrderDate DESC;

SELECT TOP 20 OrderDetailId, OrderId, FoodId, FoodName, Price, Quantity, SubTotal
FROM dbo.OrderDetails
ORDER BY OrderDetailId DESC;
GO
