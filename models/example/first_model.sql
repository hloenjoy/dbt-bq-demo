

WITH Customers as 
(


    select id as customer_id,
    first_name, 
    last_name
    from `dbt-tutorial`.jaffle_shop.customers

),

ORDERS AS 
(
    SELECT ID as order_id,
    user_id as customer_id,
    order_date,
    status 
    FROM `dbt-tutorial`.jaffle_shop.orders

),

customer_orders as 
(
    select customer_id, 
    MIN(order_date) as first_order_date,
    MAX(order_date) as most_recent_order_date,
    COUNT(Order_id) as num_of_orders
    FROM orders 
    GROUP BY 1 

),

final as 
(
    select customers.customer_id,
    customers.first_name,
    customers.last_name, 
    customer_orders.first_order_date,
    customer_orders.most_recent_order_date,
    coalesce(customer_orders.num_of_orders, 0) as num_of_orders
FROM customers 
LEFT JOIN customer_orders using(customer_id)

)

select * FROM final 
