-- PART B — CLINIC MANAGEMENT QUERIES

-----------------------------------------------------------
-- 1. Revenue from each sales channel in a year
-----------------------------------------------------------

SELECT sales_channel,
       SUM(amount) AS total_revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel;

-----------------------------------------------------------
-- 2. Top 10 most valuable customers (year)
-----------------------------------------------------------

SELECT uid,
       SUM(amount) AS total_spent
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY uid
ORDER BY total_spent DESC
LIMIT 10;

-----------------------------------------------------------
-- 3. Month-wise revenue, expense, profit & status
-----------------------------------------------------------

WITH rev AS (
    SELECT DATE_FORMAT(datetime, '%Y-%m') AS month,
           SUM(amount) AS revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = 2021
    GROUP BY month
),
exp AS (
    SELECT DATE_FORMAT(datetime, '%Y-%m') AS month,
           SUM(amount) AS expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY month
)
SELECT r.month,
       r.revenue,
       e.expense,
       (r.revenue - e.expense) AS profit,
       CASE WHEN r.revenue - e.expense > 0 
            THEN 'profitable' ELSE 'not-profitable' END AS status
FROM rev r
LEFT JOIN exp e ON r.month = e.month;

-----------------------------------------------------------
-- 4. Most profitable clinic per city (given month)
-----------------------------------------------------------

WITH monthly_profit AS (
    SELECT 
        c.city,
        cs.cid,
        SUM(cs.amount) - COALESCE(SUM(e.amount), 0) AS profit
    FROM clinics c
    LEFT JOIN clinic_sales cs ON c.cid = cs.cid 
        AND DATE_FORMAT(cs.datetime, '%Y-%m') = '2021-09'
    LEFT JOIN expenses e ON c.cid = e.cid
        AND DATE_FORMAT(e.datetime, '%Y-%m') = '2021-09'
    GROUP BY c.city, cs.cid
),
ranked AS (
    SELECT *,
        RANK() OVER (PARTITION BY city ORDER BY profit DESC) AS rnk
    FROM monthly_profit
)
SELECT city, cid, profit
FROM ranked
WHERE rnk = 1;

-----------------------------------------------------------
-- 5. Second least profitable clinic per state (given month)
-----------------------------------------------------------

WITH profit_data AS (
    SELECT 
        c.state,
        c.cid,
        COALESCE(SUM(cs.amount),0) - COALESCE(SUM(e.amount),0) AS profit
    FROM clinics c
    LEFT JOIN clinic_sales cs ON c.cid = cs.cid 
        AND DATE_FORMAT(cs.datetime,'%Y-%m')='2021-09'
    LEFT JOIN expenses e ON c.cid = e.cid
        AND DATE_FORMAT(e.datetime,'%Y-%m')='2021-09'
    GROUP BY c.state, c.cid
),
ranked AS (
    SELECT *,
        DENSE_RANK() OVER (PARTITION BY state ORDER BY profit ASC) AS rnk
    FROM profit_data
)
SELECT state, cid, profit
FROM ranked
WHERE rnk = 2;
