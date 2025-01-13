Create database Nov2024;
use Nov2024;
select * from discount_data;
select * from product_data;
select * from product_sales;

CREATE VIEW data_sales AS
SELECT
	pd.Product,
    pd.Category,
    pd.Cost_Price,
    pd.Sale_Price,
    pd.Brand,
    pd.Description,
    pd.Image_url,
    ps.Customer_Type,
    ps.Country,
    ps.Date,
    ps.Discount_Band,
    ps.Units_Sold,
    (pd.Sale_Price * ps.Units_Sold) as revenue,
	(pd.Cost_Price * ps.Units_Sold) as total_cost,
	DATE_FORMAT(ps.Date, '%M') AS Month,
	YEAR(ps.Date) AS Year
FROM product_data pd
JOIN product_sales ps
ON pd.Product_ID = ps.Product;

select * from data_sales;

select * from discount_data;
select * from data_sales_disc;
-- Drop view data_sales; 
-- Drop view data_sales_disc;

CREATE VIEW data_sales_disc AS
SELECT 
	ds.Product,
    ds.Category,
    ds.Cost_Price,
    ds.Sale_Price,
    ds.Brand,
    ds.Description,
    ds.Image_url,
    ds.Customer_Type,
    ds.Country,
    ds.Date,
    ds.Discount_Band,
    ds.Units_Sold,
    ds.revenue,
	ds.total_cost,
	ds.Month,
	ds.Year,
    db.Discount,    
    (1-db.Discount*1/100)*revenue as dis_rev
FROM     data_sales ds
JOIN     discount_data db
ON     TRIM(ds.Discount_Band) = TRIM(db.Discount_Band)
		AND ds.Month = db.Month;
