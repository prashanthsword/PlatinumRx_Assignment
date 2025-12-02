-- PART A — HOTEL MANAGEMENT SYSTEM QUERIES

-----------------------------------------------------------
-- 1. Last booked room for every user
-----------------------------------------------------------

SELECT b.user_id, b.room_no
FROM bookings b
JOIN (
    SELECT user_id, MAX(booking_date) AS last_date
    FROM bookings
    GROUP BY user_id
) x ON b.user_id = x.user_id AND b.booking_date = x.last_date;

-----------------------------------------------------------
-- 2. Booking_id and total billing for bookings in Nov 2021
-----------------------------------------------------------

SELECT bc.booking_id,
       SUM(bc.item_quantity * i.item_rate) AS total_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
JOIN bookings b ON bc.booking_id = b.booking_id
WHERE DATE(b.booking_date) BETWEEN '2021-11-01' AND '2021-11-30'
GROUP BY bc.booking_id;

-----------------------------------------------------------
-- 3. Bills in Oct 2021 with amount > 1000
-----------------------------------------------------------

SELECT bc.bill_id,
       SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE DATE(bc.bill_date) BETWEEN '2021-10-01' AND '2021-10-31'
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000;

-----------------------------------------------------------
-- 4. Most & least ordered item each month (2021)
-----------------------------------------------------------

WITH item_orders AS (
    SELECT 
        DATE_FORMAT(bc.bill_date, '%Y-%m') AS month,
        bc.item_id,
        SUM(item_quantity) AS total_qty
    FROM booking_commercials bc
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY month, bc.item_id
),
ranked AS (
    SELECT *,
        RANK() OVER (PARTITION BY month ORDER BY total_qty DESC) AS r_max,
        RANK() OVER (PARTITION BY month ORDER BY total_qty ASC) AS r_min
    FROM item_orders
)
SELECT month, item_id AS most_ordered_item
FROM ranked WHERE r_max = 1

UNION ALL

SELECT month, item_id AS least_ordered_item
FROM ranked WHERE r_min = 1;

-----------------------------------------------------------
-- 5. Users with second-highest bill each month (2021)
-----------------------------------------------------------

WITH monthly_bills AS (
    SELECT 
        u.user_id,
        DATE_FORMAT(bc.bill_date, '%Y-%m') AS month,
        SUM(bc.item_quantity * i.item_rate) AS bill_value
    FROM booking_commercials bc
    JOIN bookings b ON bc.booking_id = b.booking_id
    JOIN users u ON b.user_id = u.user_id
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY user_id, month
),
ranked AS (
    SELECT *,
        DENSE_RANK() OVER (PARTITION BY month ORDER BY bill_value DESC) AS rnk
    FROM monthly_bills
)
SELECT month, user_id, bill_value
FROM ranked
WHERE rnk = 2;
