--Looking at months with the most orders

SELECT EXTRACT(month FROM date) AS month,
COUNT(*) AS orders
FROM orders
GROUP BY month
ORDER BY month;


--Looking at the best selling types of pizza per month

SELECT EXTRACT(month FRom date) AS month,
od.pizza_id,
SUM(od.quantity) AS pizzas_sold
FROM orders AS o
LEFT JOIN order_details AS od
ON o.order_id = od.order_id
GROUP BY month, pizza_id
ORDER BY month ASC, pizzas_sold DESC;


--Looking at revenue per pizza type and total revenue

WITH revenue_table AS (
SELECT pizza_id AS pizza, SUM(quantity) AS pizzas_sold,
(SELECT price FROM pizzas AS p1
	WHERE p1.pizza_id = od.pizza_id) AS price,
SUM(quantity) * (
	SELECT price FROM pizzas AS p
	WHERE p.pizza_id = od.pizza_id
) AS revenue
FROM order_details AS od
GROUP BY pizza_id
)

SELECT pizza, price, pizzas_sold,revenue,
SUM(revenue) OVER(ORDER BY pizza) AS total_revenue
FROM revenue_table;


--Looking for customers per day

SELECT date, COUNT(*)
FROM orders
GROUP BY date
ORDER BY date;


--Looking for peak hours

SELECT EXTRACT(hour from time) AS hour,
	COUNT(*) AS customers
FROM orders
GROUP BY hour
ORDER BY customers DESC



