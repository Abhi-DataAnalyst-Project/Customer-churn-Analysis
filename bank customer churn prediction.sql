SELECT * FROM customer_analysis.`bank customer churn prediction`;

ALTER TABLE customer_prediction MODIFY COLUMN age_group VARCHAR (10) AFTER age ;

-- ================================================================================================================
-- DATA CLEANNING, PREPARATION AND UNDERSTANDING PART --

-- 1) PREPARE THE DATA SET WHERE CREDIT CARD = 1 THEN OWNED AND IF = 0 THEN NOT OWNED FOR FUTURE ANALYSIS --

ALTER TABLE customer_prediction MODIFY COLUMN credit_card VARCHAR (10) ;
ALTER TABLE customer_prediction RENAME COLUMN credit_card TO credit_card_status;

SET SQL_SAFE_UPDATES = 0;

UPDATE customer_prediction 
SET credit_card_status = 
CASE WHEN credit_card_status = '1'
     THEN 'Owned'
     ELSE 'NotOwned'
END;
     
-- 2) PREPARE THE DATA SET to see active member  = 1 THEN active AND IF = 0 THEN NOT not active FOR FUTURE ANALYSIS --

ALTER TABLE customer_prediction MODIFY COLUMN active_member VARCHAR (10);
ALTER TABLE customer_prediction RENAME COLUMN active_member TO activity_status;

UPDATE customer_prediction
SET activity_status =
CASE WHEN activity_status = '1'
     THEN 'active'
     ELSE 'Notactive'
     END;
     
-- 2) PREPARE THE DATA SET to see CHURN member  = 1 THEN YES AND IF = 0 THEN NO FOR FUTURE ANALYSIS --

ALTER TABLE customer_prediction MODIFY COLUMN churn VARCHAR (5);

UPDATE customer_prediction
SET churn = 
CASE WHEN churn = '1'
     THEN 'Yes'
     ELSE 'No'
END;

-- 3) PREPARE THE DATA SET to see Product_number FOR FUTURE ANALYSIS --

ALTER TABLE customer_prediction MODIFY COLUMN Products_number VARCHAR (10);

UPDATE customer_prediction 
SET products_number = 
CASE WHEN products_number = '1' THEN 'Prod 1'
     WHEN products_number = '2' THEN 'Prod 2'
     WHEN products_number = '3' THEN 'Prod 3'
     ELSE 'Prod 4'
END;

-- 4) CREATED AGE GROUP COLUMN FOR FUTURE ANALYSIS --

ALTER TABLE customer_prediction ADD COLUMN age_group VARCHAR (10) AFTER age;

UPDATE customer_prediction 
SET age_group = 
CASE WHEN age <=30 THEN '18-30'
	 WHEN age <=40 THEN '30-40'
     WHEN age <=50 THEN '40-50'
     WHEN age <=60 THEN '50-60'
     WHEN age <=70 THEN '60-70'
     ELSE '70-90'
END;

-- 5) CREATED CREADIT SCORE GROUP COLUMN FOR FUTURE ANALYSIS --

ALTER TABLE customer_prediction ADD COLUMN credit_score_group VARCHAR (10) AFTER credit_score;

UPDATE customer_prediction 
SET credit_score_group =
CASE WHEN Credit_score < 400 THEN '<400'
     WHEN credit_score <=500 THEN '400-500'
     WHEN credit_score <=600 THEN '500-600'
     WHEN credit_score <=700 THEN '600-700'
     WHEN credit_score <=800 THEN '700-800'
     ELSE '>800'
END;

-- 6) CREATED available balance GROUP COLUMN FOR FUTURE ANALYSIS

ALTER TABLE customer_prediction ADD COLUMN avl_bal_group VARCHAR (10) AFTER balance;

UPDATE customer_prediction 
SET avl_bal_group =
CASE WHEN balance <= 0 THEN '0'
     WHEN balance <= 1000 THEN '1-1k'
     when balance <= 10000 THEN '1K-10K'
     WHEN balance <= 100000 THEN '10K-100K'
     WHEN balance <= 200000 THEN '100K-200K'
     ELSE '>200K'
END;


CREATE TABLE age_group (
age_goup VARCHAR (10),
age_group_ID INT PRIMARY KEY AUTO_INCREMENT );

CREATE TABLE credit_score (
Credit_score_group VARCHAR (10) ,
ID INT PRIMARY KEY AUTO_INCREMENT );

CREATE TABLE account_balance (
balance_group VARCHAR (15),
ID INT PRIMARY KEY AUTO_INCREMENT) ;

ALTER TABLE age_group AUTO_INCREMENT = 1;
ALTER TABLE credit_score AUTO_INCREMENT = 1;
ALTER TABLE account_balance AUTO_INCREMENT = 1; 

INSERT INTO age_group (age_goup) VALUES
('18-30'),
('30-40'),
('40-50'),
('50-60'),
('60-70'),
('70-90');

INSERT INTO credit_score (Credit_score_group) VALUES
('<400'),
('400-500'),
('500-600'),
('600-700'),
('700-800'),
('>800');

INSERT INTO account_balance (balance_group) VALUES
('0'),
('1-1K'),
('1K-10K'),
('10K-100K'),
('100K-200K'),
('>200K');

-- ================================================================================================================================
