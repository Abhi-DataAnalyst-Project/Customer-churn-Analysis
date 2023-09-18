USE customer_analysis;

-- 1) Find Total no of customers? --

SELECT COUNT(DISTINCT (customer_id)) FROM customer_prediction; 

-- 2) Find How many customer lost ? --

SELECT COUNT(churn) AS lost_customers FROM customer_prediction
WHERE churn = 'yes';

-- 3) Find Out churn rate % ? --

SELECT 
	Total_Customers,
	Total_lost_customers,
	ROUND(((Total_lost_customers  / Total_customers ) *100 ), 2) AS
	Churn_rate
FROM
	(SELECT
		COUNT(*) AS total_customers
	FROM
		customer_prediction) total,
	(SELECT 
		COUNT(*) AS total_lost_customers
	FROM 
		customer_prediction
	WHERE
		customer_prediction.churn = 'Yes') Yes;
		
        
-- 4) Find out total no of male & Female customers;

SELECT gender, COUNT(DISTINCT (customer_id)) AS total_customer
FROM customer_prediction
GROUP BY gender 
ORDER BY total_customer DESC;

-- 5) Find out total no of lost customer between male & famele ?

SELECT gender , COUNT( churn) AS lost_customer
FROM customer_prediction
WHERE churn = 'yes'
GROUP BY gender 
ORDER BY lost_customer DESC;

-- 6) Find Out how many customers are active and notactive ? --

SELECT activity_status , COUNT(customer_id) AS total_customers
FROM customer_prediction
GROUP BY activity_status
ORDER BY total_customers DESC;

-- 7) Find out Country wise total customers ? --

SELECT country, COUNT(customer_id) AS total_customers 
FROM customer_prediction
GROUP BY country
ORDER BY total_customers DESC;

-- 8) Find out total customer by credit card status ? --

SELECT credit_card_status , COUNT(customer_id) AS total_customers
FROM customer_prediction
GROUP BY credit_card_status
ORDER BY total_customers DESC;

-- 9) Find out age group wise total customers ? --

SELECT age_group, COUNT(customer_id) AS total_customers 
FROM customer_prediction
GROUP BY age_group
ORDER BY total_customers DESC;

-- 10) Find out credit score wise total customers ? --

SELECT credit_score_group, COUNT(customer_id) AS total_customers
FROM customer_prediction
GROUP BY credit_score_group
ORDER BY total_customers DESC;

-- 11) Find out Account balance wise total customers

SELECT avl_bal_group, COUNT(customer_id) AS total_customers
FROM customer_prediction
GROUP BY avl_bal_group
ORDER BY total_customers DESC;

-- 12) Find tenure by custmers ? --

SELECT 
CASE WHEN tenure <=2 THEN '0-2 Years'
     WHEN tenure <=5 THEN '2-5 Years'
     WHEN tenure <=8 THEN '5-8 Years'
     ELSE '8-10 Years'
     END AS tenure_group,
COUNT(customer_id) AS total_customers
FROM customer_prediction
GROUP BY tenure_group
ORDER BY total_customers DESC ;




