-- Assessment_Q2.sql
-- Transaction Frequency Analysis: Classify customers by transaction frequency

WITH customer_transactions AS (
    SELECT
        u.id AS customer_id,
        u.name,
        COUNT(sa.id) AS total_transactions,
        TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months
    FROM users_customuser u
    LEFT JOIN savings_savingsaccount sa ON u.id = sa.owner_id
    WHERE u.disabled_at IS NULL  -- Optional: only include active users
    GROUP BY u.id, u.name, u.date_joined
),
customer_avg AS (
    SELECT
        customer_id,
        name,
        total_transactions,
        CASE WHEN tenure_months = 0 THEN 1 ELSE tenure_months END AS tenure_months,
        CAST(total_transactions AS DECIMAL(10,2)) / CASE WHEN tenure_months = 0 THEN 1 ELSE tenure_months END AS avg_transactions_per_month,
        CASE
            WHEN CAST(total_transactions AS DECIMAL(10,2)) / CASE WHEN tenure_months = 0 THEN 1 ELSE tenure_months END >= 10 THEN 'High Frequency'
            WHEN CAST(total_transactions AS DECIMAL(10,2)) / CASE WHEN tenure_months = 0 THEN 1 ELSE tenure_months END BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM customer_transactions
)

SELECT
    frequency_category,
    COUNT(customer_id) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM customer_avg
GROUP BY frequency_category
ORDER BY
    CASE frequency_category
        WHEN 'High Frequency' THEN 1
        WHEN 'Medium Frequency' THEN 2
        WHEN 'Low Frequency' THEN 3
    END;
