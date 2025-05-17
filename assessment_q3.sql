-- Assessment_Q3.sql
-- Identify savings and investment accounts with no inflow in the last 365 days

-- Savings accounts
SELECT
    sa.id AS plan_id,
    sa.owner_id,
    'Savings' AS type,
    MAX(sa.transaction_date) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(sa.transaction_date)) AS inactivity_days
FROM savings_savingsaccount sa
WHERE sa.confirmed_amount > 0
GROUP BY sa.id, sa.owner_id
HAVING MAX(sa.transaction_date) < CURDATE() - INTERVAL 365 DAY

UNION

-- Investment plans
SELECT
    pp.id AS plan_id,
    pp.owner_id,
    'Investment' AS type,
    MAX(pp.created_on) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(pp.created_on)) AS inactivity_days
FROM plans_plan pp
WHERE pp.is_a_fund = 1
GROUP BY pp.id, pp.owner_id
HAVING MAX(pp.created_on) < CURDATE() - INTERVAL 365 DAY;
