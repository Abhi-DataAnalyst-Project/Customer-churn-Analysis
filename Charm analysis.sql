USE INVENTORY;

SELECT * FROM customer;
SELECT * FROM PLUGELECTRONICS;


-- 1) create a new column called customer status to find out churn and not churn customers ? --

ALTER TABLE customer ADD COLUMN customerstatus Varchar (30) ;
SET SQL_SAFE_UPDATES = 0;

UPDATE customer 
SET customerstatus = 
                    CASE when loyaltyprogram = 1 
                    THEN 'Not Churn'
                    ELSE 'Churn'
END;

-- 2) Find out risk customers ?

SELECT COUNT(Customerstatus) AS risk_customer
FROM customer
WHERE customerstatus = 'Churn' ; 

-- 3) Find out current customers ? 

SELECT COUNT(Customerstatus) AS Current_customer
FROM customer
WHERE customerstatus = 'Not Churn' ;


SELECT (COUNT(customerstatus) - COUNT(custkey)) / 100 AS churn_rate
FROM customer
WHERE customerstatus = 'Churn';

-- 2) Find out total no of customers ?

SELECT COUNT(custkey) FROM customer;

-- 2) region wise total customers ?

SELECT Custregion, COUNT(custname) AS no_of_customer FROM customer
GROUP BY custregion
ORDER BY no_of_customer DESC;

-- 3) find no of customer by customer type wise ?

SELECT custtype,COUNT(custtype) AS no_of_customers FROM customer
GROUP BY custtype
ORDER BY no_of_customers DESC;

-- 4) Find out no of male and female customer ?

SELECT custgender , COUNT(custgender) AS customer FROM customer
GROUP BY custgender
ORDER BY customer DESC;

-- 5) find out abge group wise customer 

SELECT agegroup, COUNT(agegroup) AS no_of_customer FROM customer
GROUP BY agegroup
ORDER BY no_of_customer;

-- 6) find charmed and not charmed ?

SELECT custregion, custtype, custgender, agegroup, loyaltyprogram,
CASE 
    WHEN loyaltyprogram  = 1 THEN 'Charmed'
								ELSE 'Not Charmed'
	END AS cust_status 
FROM customer;

ALTER TABLE customer MODIFY COLUMN custsince timestamp;

-- 

SELECT Custname, custgender, agegroup,
timestampdiff(YEAR, custsince, CURRENT_DATE()) AS years
FROM customer;

SELECT * FROM CUSTOMER;

-- what is the total amount spent cash customer buying the product type ?

SELECT cust_key , customer_name , product_type , SUM(sales) AS total_amount FROM plugelectronics P
JOIN customer c
ON (P. cust_key = C . custkey)
GROUP BY cust_key, customer_name, product_type 
ORDER BY total_amount DESC 
LIMIT 10 ;


