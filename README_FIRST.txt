CRAVE & CO. - ASP.NET WEB FORMS FOOD ORDERING WEBSITE
======================================================

This package contains the complete website files for an ASP.NET Web Forms project targeting .NET Framework 4.8.

IMPORTANT:
- Do not open this folder as a standalone project.
- In Visual Studio, create a fresh "ASP.NET Web Application (.NET Framework)" project.
- Select "Web Forms".
- Close Visual Studio after creating the empty project.
- Copy ALL files from this package into that project folder and replace matching files.
- Do NOT replace your Visual Studio-generated .csproj file.
- Reopen the project.
- Set Default.aspx as the Start Page.
- Build > Clean Solution.
- Build > Rebuild Solution.

DATABASE SETUP
--------------
1. Open SQL Server Management Studio.
2. Open Database.sql from this package.
3. Execute the script.
4. The script creates CraveCoFoodOrderingDB and creates all tables and 48 menu items.
5. Web.config is configured for:
   Data Source=localhost

If your SQL Server instance is different, change ONLY the Data Source value in Web.config.
Examples:
   localhost
   .\SQLEXPRESS
   (localdb)\MSSQLLocalDB

WEBSITE FEATURES
----------------
- Home page
- 48 menu items
- 8 categories, 6 items each
- Category filtering
- Add to cart
- Cart summary
- User registration
- User login
- Logout
- Checkout
- Cash on Delivery / UPI / Card selection
- Order confirmation
- My Orders
- SQL Server database
- Soft modern lavender / blush / powder-blue design

The site uses CodeFile directives consistently because this setup is intended to work with the Web Forms project structure used in Visual Studio.


V3 updates: cream + soft maroon theme, refreshed food image URLs, and fallback image handling for broken remote images.


ADMIN + DATABASE UPDATE
=======================
Database name: CraveCoFoodOrderingDB
Run Database.sql in SQL Server before running the website.
Admin login: AdminLogin.aspx
Admin email: admin@craveco.local
Admin password: Admin@123
The original design/theme files were retained; only the requested admin panel, quantity selector, INR/database connection updates were added.


PAYMENT DETAILS UPDATE
----------------------
Checkout now asks for UPI ID when UPI is selected, or cardholder name, card number, expiry and CVV when Card is selected. The demo validates these fields. It does NOT connect to a real bank/payment gateway and it does NOT store the full card number or CVV; only a reference such as 'Card ending 1234' is stored.

If CraveCoFoodOrderingDB already exists and you do not want to delete existing orders, run Database_Update_Payment.sql once. If you are creating the database from scratch, run Database.sql.

ORDER DETAILS
-------------
Checkout saves one OrderDetails row for every cart item inside the same database transaction as Orders. Quantity and SubTotal are saved/calculated from the cart.
