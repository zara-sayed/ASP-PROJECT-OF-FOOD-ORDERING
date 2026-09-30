/* CRAVE & CO. DATABASE SETUP - safe to run again for a fresh demo database. */
IF DB_ID('CraveCoFoodOrderingDB') IS NULL
BEGIN
    CREATE DATABASE CraveCoFoodOrderingDB;
END
GO

USE CraveCoFoodOrderingDB;
GO

IF OBJECT_ID('dbo.OrderDetails','U') IS NOT NULL DROP TABLE dbo.OrderDetails;
IF OBJECT_ID('dbo.Orders','U') IS NOT NULL DROP TABLE dbo.Orders;
IF OBJECT_ID('dbo.FoodItems','U') IS NOT NULL DROP TABLE dbo.FoodItems;
IF OBJECT_ID('dbo.AdminUsers','U') IS NOT NULL DROP TABLE dbo.AdminUsers;
IF OBJECT_ID('dbo.Users','U') IS NOT NULL DROP TABLE dbo.Users;
GO

CREATE TABLE Users(
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(150) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(64) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE AdminUsers(
    AdminId INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(150) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(64) NOT NULL
);

CREATE TABLE FoodItems(
    FoodId INT IDENTITY(1,1) PRIMARY KEY,
    FoodName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(300) NULL,
    Category NVARCHAR(40) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    ImageUrl NVARCHAR(500) NOT NULL,
    IsAvailable BIT NOT NULL DEFAULT 1
);

CREATE TABLE Orders(
    OrderId INT IDENTITY(1001,1) PRIMARY KEY,
    UserId INT NULL,
    CustomerName NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    Address NVARCHAR(500) NOT NULL,
    PaymentMethod NVARCHAR(40) NOT NULL,
    PaymentReference NVARCHAR(200) NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    OrderStatus NVARCHAR(40) NOT NULL DEFAULT 'Placed',
    OrderDate DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Orders_Users FOREIGN KEY(UserId) REFERENCES Users(UserId)
);

CREATE TABLE OrderDetails(
    OrderDetailId INT IDENTITY(1,1) PRIMARY KEY,
    OrderId INT NOT NULL,
    FoodId INT NOT NULL,
    FoodName NVARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Quantity INT NOT NULL,
    SubTotal AS (Price * Quantity) PERSISTED,
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY(OrderId) REFERENCES Orders(OrderId),
    CONSTRAINT FK_OrderDetails_Food FOREIGN KEY(FoodId) REFERENCES FoodItems(FoodId)
);
GO

INSERT INTO AdminUsers(FullName, Email, PasswordHash)
VALUES('Crave & Co. Admin','admin@craveco.local','e86f78a8a3caf0b60d8e74e5942aa6d86dc150cd3c03338aef25b7d2d7e3acc7');
GO

INSERT INTO FoodItems(FoodName,Description,Category,Price,ImageUrl) VALUES
('Margherita Pizza','Tomato, mozzarella, basil and a golden baked crust.','Pizza',299,'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=900&q=85'),
('Farmhouse Pizza','Onion, capsicum, mushrooms and sweet corn.','Pizza',349,'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=900&q=85'),
('Peri Peri Paneer Pizza','Spiced paneer, peppers, onion and peri peri drizzle.','Pizza',379,'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=900&q=85'),
('Truffle Mushroom Pizza','Mushrooms, mozzarella, herbs and a truffle finish.','Pizza',429,'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=900&q=85'),
('BBQ Chicken Pizza','Smoky chicken, onions, mozzarella and BBQ sauce.','Pizza',399,'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=900&q=85'),
('Four Cheese Pizza','Mozzarella, cheddar, parmesan and creamy cheese sauce.','Pizza',449,'https://images.unsplash.com/photo-1515003197210-e0cd71810b5f?auto=format&fit=crop&w=900&q=85'),
('Classic Burger','Juicy patty, lettuce, tomato and house sauce.','Burger',249,'https://images.unsplash.com/photo-1601050690597-df0568f70950?auto=format&fit=crop&w=900&q=85'),
('Crispy Chicken Burger','Crispy chicken, lettuce and creamy burger sauce.','Burger',299,'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?auto=format&fit=crop&w=900&q=85'),
('Smoky BBQ Burger','Grilled patty, caramelised onion and smoky BBQ glaze.','Burger',329,'https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=900&q=85'),
('Paneer Crunch Burger','Crispy paneer, lettuce, tomato and mint mayo.','Burger',279,'https://images.unsplash.com/photo-1515003197210-e0cd71810b5f?auto=format&fit=crop&w=900&q=85'),
('Double Cheese Burger','Double patties, melted cheese and signature sauce.','Burger',369,'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?auto=format&fit=crop&w=900&q=85'),
('Spicy Jalapeno Burger','Cheesy patty, jalapenos and creamy chipotle sauce.','Burger',319,'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?auto=format&fit=crop&w=900&q=85'),
('Pasta Alfredo','Creamy parmesan sauce with herbs and pasta.','Pasta',279,'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=900&q=85'),
('Arrabbiata Pasta','Tomato chilli sauce, herbs and parmesan.','Pasta',259,'https://images.unsplash.com/photo-1515003197210-e0cd71810b5f?auto=format&fit=crop&w=900&q=85'),
('Pesto Penne','Basil pesto, cherry tomatoes and parmesan.','Pasta',289,'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=900&q=85'),
('Creamy Pink Sauce Pasta','Tomato cream sauce, herbs and parmesan.','Pasta',299,'https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=900&q=85'),
('Chicken Parmesan Pasta','Tender chicken, tomato sauce and parmesan.','Pasta',339,'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?auto=format&fit=crop&w=900&q=85'),
('Mushroom Garlic Pasta','Garlic butter, mushrooms, herbs and parmesan.','Pasta',289,'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?auto=format&fit=crop&w=900&q=85'),
('Veg Hakka Noodles','Wok-tossed noodles with vegetables and soy sauce.','Asian',239,'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?auto=format&fit=crop&w=900&q=85'),
('Schezwan Noodles','Spicy noodles with vegetables and schezwan sauce.','Asian',249,'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?auto=format&fit=crop&w=900&q=85'),
('Veg Fried Rice','Fragrant rice tossed with vegetables and spring onion.','Asian',229,'https://images.unsplash.com/photo-1565958011703-44f9829ba187?auto=format&fit=crop&w=900&q=85'),
('Thai Red Curry','Creamy Thai curry with vegetables and fragrant herbs.','Asian',329,'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?auto=format&fit=crop&w=900&q=85'),
('Chilli Paneer','Crispy paneer with peppers in a tangy chilli sauce.','Asian',279,'https://images.unsplash.com/photo-1601050690597-df0568f70950?auto=format&fit=crop&w=900&q=85'),
('Veg Momos','Steamed dumplings with a spicy house dip.','Asian',179,'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?auto=format&fit=crop&w=900&q=85'),
('Butter Chicken','Tender chicken in a rich tomato butter gravy.','Indian',349,'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=900&q=85'),
('Paneer Tikka Masala','Charred paneer in a creamy spiced tomato gravy.','Indian',319,'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=900&q=85'),
('Dal Makhani','Slow-cooked black lentils finished with butter and cream.','Indian',249,'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=900&q=85'),
('Veg Biryani','Fragrant basmati rice layered with vegetables and spices.','Indian',289,'https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=900&q=85'),
('Garlic Naan','Soft tandoor naan topped with garlic and butter.','Indian',99,'https://images.unsplash.com/photo-1601050690597-df0568f70950?auto=format&fit=crop&w=900&q=85'),
('Chole Bhature','Spiced chickpeas served with fluffy fried bhature.','Indian',229,'https://images.unsplash.com/photo-1515003197210-e0cd71810b5f?auto=format&fit=crop&w=900&q=85'),
('Loaded French Fries','Crispy fries with seasoning and creamy dip.','Snacks',159,'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?auto=format&fit=crop&w=900&q=85'),
('Cheese Garlic Bread','Toasted garlic bread with a generous cheese topping.','Snacks',189,'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?auto=format&fit=crop&w=900&q=85'),
('Crispy Corn','Crunchy sweet corn tossed with herbs and seasoning.','Snacks',169,'https://images.unsplash.com/photo-1565958011703-44f9829ba187?auto=format&fit=crop&w=900&q=85'),
('Paneer Popcorn','Crispy bite-sized paneer with a smoky dip.','Snacks',219,'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?auto=format&fit=crop&w=900&q=85'),
('Chicken Wings','Crispy wings tossed in your choice of house glaze.','Snacks',299,'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?auto=format&fit=crop&w=900&q=85'),
('Nachos Supreme','Corn nachos with cheese, salsa, jalapenos and sour cream.','Snacks',229,'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?auto=format&fit=crop&w=900&q=85'),
('Chocolate Brownie','Warm chocolate brownie with a rich centre.','Dessert',149,'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=900&q=85'),
('Strawberry Cheesecake','Creamy cheesecake with strawberry topping.','Dessert',229,'https://images.unsplash.com/photo-1565958011703-44f9829ba187?auto=format&fit=crop&w=900&q=85'),
('Tiramisu Cup','Coffee-soaked sponge, mascarpone and cocoa.','Dessert',249,'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=900&q=85'),
('Red Velvet Cake','Soft red velvet sponge with cream cheese frosting.','Dessert',219,'https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=900&q=85'),
('Gulab Jamun','Warm syrup-soaked milk dumplings with cardamom.','Dessert',139,'https://images.unsplash.com/photo-1601050690597-df0568f70950?auto=format&fit=crop&w=900&q=85'),
('Choco Lava Cake','Warm chocolate cake with a molten centre.','Dessert',189,'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?auto=format&fit=crop&w=900&q=85'),
('Fresh Lime Soda','Bright, chilled and lightly sparkling.','Drinks',99,'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?auto=format&fit=crop&w=900&q=85'),
('Cold Coffee','Chilled coffee blended until smooth and creamy.','Drinks',139,'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?auto=format&fit=crop&w=900&q=85'),
('Mango Cooler','Chilled mango drink with a fresh citrus finish.','Drinks',129,'https://images.unsplash.com/photo-1565958011703-44f9829ba187?auto=format&fit=crop&w=900&q=85'),
('Berry Iced Tea','Refreshing iced tea with mixed berry notes.','Drinks',129,'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?auto=format&fit=crop&w=900&q=85'),
('Virgin Mojito','Mint, lime and sparkling soda served ice cold.','Drinks',149,'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?auto=format&fit=crop&w=900&q=85'),
('Iced Mocha','Cold coffee, cocoa and milk with a smooth finish.','Drinks',159,'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?auto=format&fit=crop&w=900&q=85');
GO
