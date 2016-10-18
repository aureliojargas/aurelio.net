
-- o valor dos pedidos colocados por clientes.total_price
select customer.customer_num, sum(items.total_price)
from orders, customer, items
where customer.customer_num = orders.customer_num
AND orders.order_num = items.order_num
group by customer.customer_num
order by customer.customer_num;

-- o valor máximo de todos pedidos
select max(items.total_price) valor_max,
		 min(items.total_price) valor_min,
		 sum(items.total_price) total
from orders, customer, items
where customer.customer_num = orders.customer_num
AND orders.order_num = items.order_num
