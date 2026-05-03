create database capstone;


use capstone;

select* from customers;
select* from accounts;
select* from complaints;
select* from loan;
select* from loan_payment;
select* from transaction;

show tables;

 ## SQL Analysis Queries (Important for Portfolio)


# Total Customers
SELECT COUNT(*) FROM customers;

# count Customers by City
select city,count(*) as Total_customers from 
customers group by city order by Total_customers desc;

# Total Bank Balance
select sum(balance) from accounts;

# Top 10 Rich Customers
 select c.name,a.balance from customers c
 join accounts  a on c.customer_id = a.customer_id 
 order by a.balance desc limit 10;

# Loan Distribution
select loan_type ,count(*) from loan
group by loan_type;

# Monthly Transaction Trend
select month(transaction_date) as month,
sum(amount) as total_amount
from transaction
group by month order by month ;

# # Customer Analysis Queries

# Total Customers
SELECT COUNT(*) AS total_customers
FROM customers;

# Customers by Gender
SELECT gender, COUNT(*) AS total
FROM customers
GROUP BY gender;


# Customers by City
SELECT city, COUNT(*) AS customers
FROM customers
GROUP BY city
ORDER BY customers DESC;

# Average Customer Income
SELECT AVG(income) AS avg_income
FROM customers;

# Customers by Occupation
SELECT occupation, COUNT(*)
FROM customers
GROUP BY occupation
ORDER BY COUNT(*) DESC;

# # Account Analysis

# Total Accounts
SELECT COUNT(*) 
FROM accounts;

# Account Type Distribution
SELECT account_type, COUNT(*)
FROM accounts
GROUP BY account_type;

#Total Bank Balance
SELECT SUM(balance) AS total_balance
FROM accounts;

# Average Account Balance
SELECT AVG(balance)
FROM accounts;

# Top 10 Accounts by Balance
SELECT account_id, balance
FROM accounts
ORDER BY balance DESC
LIMIT 10;

# # Transaction Analysis

# Total Transactions
SELECT COUNT(*)
FROM transaction;

# Total Transaction Amount
SELECT SUM(amount)
FROM transaction;

# Transaction Type Breakdown
SELECT transaction_type, COUNT(*)
FROM transaction
GROUP BY transaction_type;

# Payment Method Analysis
SELECT payment_method, COUNT(*)
FROM transaction
GROUP BY payment_method;

# Monthly Transaction Trend
SELECT 
MONTH(transaction_date) AS month,
SUM(amount) AS total_amount
FROM transaction
GROUP BY month
ORDER BY month;

# # Loan Analysis

#Total Loans
SELECT COUNT(*) 
FROM loan;

# Loan Amount Distribution
SELECT loan_type, SUM(loan_amount)
FROM loan
GROUP BY loan_type;

# Average Interest Rate
SELECT AVG(interest_rate)
FROM loan;

# Loan Status Distribution
SELECT loan_status, COUNT(*)
FROM loan
GROUP BY loan_status;

# Customers with Loans
SELECT DISTINCT customer_id
FROM loan;

# # Complaint Analysis

# Total Complaints
SELECT COUNT(*)
FROM complaints;

# Complaint Type Distribution
SELECT complaint_type, COUNT(*)
FROM complaints
GROUP BY complaint_type;

# Complaint Status
SELECT status, COUNT(*)
FROM complaints
GROUP BY status;

### Joins

# Top 10 Customers by Account Balance
SELECT c.name, a.balance
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
ORDER BY balance DESC
LIMIT 10;

# Customers with Loans and Accounts
SELECT c.name, l.loan_amount, a.balance
FROM customers c
JOIN loan l
ON c.customer_id = l.customer_id
JOIN accounts a
ON c.customer_id = a.customer_id;

# Transactions by City
SELECT c.city, SUM(t.amount) FROM transaction t
JOIN accounts a
ON t.account_id = a.account_id
JOIN customers c
ON a.customer_id = c.customer_id
GROUP BY c.city; 





# Top 5  High Value Customers Accounts (Based on Transactions)

SELECT account_id,SUM(amount) AS total_spent FROM transaction
GROUP BY account_id
ORDER BY total_spent DESC
LIMIT 5;

# Loan Distribution 

SELECT loan_id,loan_amount
FROM loan ORDER BY loan_amount DESC;

# Loan Repayment Trend

SELECT l.loan_id,l.loan_amount,SUM(lp.payment_amount) AS total_paid
FROM loan l
JOIN loan_payment lp
ON l.loan_id = lp.loan_id
GROUP BY l.loan_id, l.loan_amount;

# Payment Mode 

SELECT payment_method,COUNT(*) AS total_transactions,
SUM(amount) AS total_amount
FROM transaction
GROUP BY payment_method;

# Transaction Growth Month Wise

SELECT MONTH(transaction_date) AS month,COUNT(*) AS total_transactions,
SUM(amount) AS total_amount FROM transaction
GROUP BY MONTH(transaction_date)
ORDER BY month;

# Complaints trend and resolution status

SELECT MONTH(complaint_date) AS month,status,
COUNT(*) AS total_complaints
FROM complaints
GROUP BY MONTH(complaint_date), status
ORDER BY month;

# understanding of customers

SELECT c.customer_id,c.name,COUNT(t.transaction_id) AS total_transactions,
SUM(t.amount) AS total_spent FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transaction t ON a.account_id = t.account_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC;