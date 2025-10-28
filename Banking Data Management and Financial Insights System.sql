Create database Bank;
Use Bank;
Select * From bank_account_data
Select * From bank_branch_data;
Select * From bank_customer_data
Select * From bank_loan_data
Select * From bank_transacation_data


-- 1. Total customers per branch
SELECT b.BRANCH_NAME, COUNT(c.CUSTOMER_ID) AS total_customers
FROM bank_account_data a
JOIN bank_customer_Data c ON a.CUSTOMER_ID = c.CUSTOMER_ID
JOIN bank_branch_data b ON a.BRANCH_ID= b.BRANCH_ID
GROUP BY b.BRANCH_NAME;

-- 2. Average account balance per city
SELECT c.city, AVG(a.OPENING_BALANCE) AS avg_balance
FROM bank_customer_Data c
JOIN bank_account_data a ON c.customer_id = a.customer_id
GROUP BY c.city;

-- 3. Top 5 customers with the highest total balance
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       SUM(a.OPENING_BALANCE) AS total_balance
FROM bank_customer_data c
JOIN bank_account_data a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY total_balance DESC
LIMIT 5;

-- 4. Total loan amount per branch
SELECT b.branch_name,SUM(l.LOAN_AMOUNT) AS total_loans
FROM bank_loan_data l
JOIN bank_customer_data c ON l.customer_id = c.customer_id
JOIN bank_branch_data b ON c.branch_id = b.branch_id
GROUP BY b.branch_name;

-- 5. loan detail 
SELECT l.loan_id, l.customer_id, b.branch_id, b.branch_name, l.loan_amount, c.First_Name
FROM bank_loan_data l
JOIN bank_customer_data c ON l.customer_id = c.customer_id
JOIN bank_branch_data b ON l.branch_id = b.branch_id
ORDER BY l.loan_amount DESC;


-- 6. Monthly transaction volume trend
SELECT DATE_FORMAT(TRANSCATION_DATE, '%Y-%m') AS month,
       COUNT(TRANSCATION_ID) AS total_transactions
FROM bank_transacation_data
GROUP BY month
ORDER BY month;

-- 7. Most active customers by transaction frequency
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       COUNT(t.TRANSCATION_ID) AS num_transactions
FROM bank_customer_data c
JOIN bank_account_data a ON c.customer_id = a.customer_id
JOIN bank_transacation_data t ON a.account_id = t.account_id
GROUP BY c.customer_id, customer_name
ORDER BY num_transactions DESC
LIMIT 10;
