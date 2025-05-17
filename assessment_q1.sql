-- Assessment_Q1.sql
-- High-Value Customers with Multiple Products
-- Find customers with at least one funded savings plan AND one funded investment plan
-- Output: owner_id, name (first + last), savings_count, investment_count, total_deposits
-- Sorted by total deposits in descending order

WITH savings_plans AS (
    SELECT owner_id
    FROM plans_plan
    WHERE is_regular_savings = 1
    GROUP BY owner_id
),
investment_plans AS (
    SELECT owner_id
    FROM plans_plan
    WHERE is_a_fund = 1
    GROUP BY owner_id
),
customer_plans AS (
    SELECT
        u.id AS owner_id,
        COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) AS savings_count,
        COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) AS investment_count
    FROM users_customuser u
    LEFT JOIN plans_plan p ON u.id = p.owner_id
    GROUP BY u.id
),
total_deposits AS (
    SELECT
        owner_id,
        SUM(confirmed_amount) / 100.0 AS total_deposits -- Convert from kobo to main currency
    FROM savings_savingsaccount
    GROUP BY owner_id
)

SELECT
    cp.owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    cp.savings_count,
    cp.investment_count,
    COALESCE(td.total_deposits, 0) AS total_deposits
FROM customer_plans cp
JOIN users_customuser u ON cp.owner_id = u.id
JOIN savings_plans sp ON cp.owner_id = sp.owner_id
JOIN investment_plans ip ON cp.owner_id = ip.owner_id
LEFT JOIN total_deposits td ON cp.owner_id = td.owner_id
ORDER BY total_deposits DESC;
