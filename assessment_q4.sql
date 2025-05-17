-- Assessment_Q4.sql
-- Estimate Customer Lifetime Value (CLV)

SELECT
    u.id AS customer_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,
    COUNT(sa.id) AS total_transactions,
    
    -- CLV = (total_txns / tenure) * 12 * avg_profit_per_txn
    ROUND(
        (COUNT(sa.id) / NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()), 0)) 
        * 12 * (AVG(sa.confirmed_amount) * 0.001 / 100), 2
    ) AS estimated_clv

FROM users_customuser u
JOIN savings_savingsaccount sa ON u.id = sa.owner_id
WHERE sa.confirmed_amount > 0

GROUP BY u.id, name, u.date_joined
ORDER BY estimated_clv DESC;
