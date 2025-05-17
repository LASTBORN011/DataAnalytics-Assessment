# DataAnalytics-Assessment

This repository contains my SQL solutions for the SQL Proficiency Assessment designed to test data analysis skills through relational database queries. The tasks involved retrieving, aggregating, and analyzing customer and transaction data to support business insights.

---

## 📌 Questions & Explanations

### Question 1: High-Value Customers with Multiple Products

**Objective:** Identify customers who have both funded savings and investment plans for cross-selling opportunities.  
**Approach:**  
- Counted funded savings plans from `savings_savingsaccount` (confirmed_amount > 0)  
- Counted funded investment plans from `plans_plan` (is_a_fund = 1)  
- Joined with `users_customuser` for customer details  
- Filtered to include customers with at least one plan in both categories  
- Sorted results by total deposits

---

### Question 2: Transaction Frequency Analysis

**Objective:** Categorize customers by their transaction frequency per month.  
**Approach:**  
- Calculated the number of transactions per customer per month using `savings_savingsaccount`  
- Computed average monthly transactions for each customer  
- Categorized customers into High (≥10), Medium (3-9), and Low (≤2) frequency groups  
- Summarized the counts and average transactions for each group

---

### Question 3: Account Inactivity Alert

**Objective:** Identify active savings or investment accounts with no inflow transactions in the last year (365 days).  
**Approach:**  
- Used `transaction_date` from `savings_savingsaccount` and `created_on` from `plans_plan`  
- Determined last transaction dates per account  
- Calculated inactivity period in days  
- Filtered for inactivity greater than 365 days  
- Returned plan/account details with inactivity metrics

---

### Question 4: Customer Lifetime Value (CLV) Estimation

**Objective:** Estimate the CLV for each customer based on tenure and transaction history.  
**Approach:**  
- Calculated account tenure in months from `date_joined` in `users_customuser`  
- Aggregated total transactions and average transaction value from `savings_savingsaccount`  
- Used simplified CLV formula:  
  `CLV = (total_transactions / tenure_months) * 12 * avg_profit_per_transaction`  
- Assumed profit per transaction = 0.1% of transaction value (converted from kobo to Naira)  
- Sorted customers by estimated CLV descending

---

## 🚧 Challenges Faced

- Differences in actual column names versus those specified in the assessment instructions (e.g., `created_on` instead of `created_at`, `date_joined` instead of `signup_date`) required adjustments to queries.  
- Some expected columns like `confirmed_amount` were missing; used alternative columns and logic where needed.  
- Ensured all amount values were properly converted from kobo to Naira to maintain financial accuracy.  
- Calculating date differences and handling NULLs for inactive accounts required careful SQL handling.

---

## 🛠️ Technologies Used

- MySQL 8.x  
- MySQL Workbench  
- Git and GitHub for version control and submission  

---

## ✅ How to Run

Each `.sql` file (Assessment_Q1.sql to Assessment_Q4.sql) contains a standalone query to answer the respective question.  
Run the queries in a MySQL environment connected to the provided database schema to obtain the results.

---

Thank you for reviewing my SQL assessment submission.
