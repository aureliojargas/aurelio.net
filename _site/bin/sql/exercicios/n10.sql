
-- qual o item mais vendido no geral?

-- por cliente
select count(manufact.manu_code), customer_num
from manufact, orders, items
where manufact.manu_code = items.manu_code
AND orders.order_num = items.order_num
group by customer_num;

-- por estado
select count(manufact.manu_code), state
from manufact, orders, items, customer
where manufact.manu_code = items.manu_code
AND orders.order_num = items.order_num
AND customer.customer_num = orders.customer_num
group by state
