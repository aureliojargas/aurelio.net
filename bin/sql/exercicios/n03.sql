-- quantos clientes possuem pedido e quais são: 17
select lname
from customer
where customer.customer_num
IN (select orders.customer_num from orders)
order by lname;

select count(lname)
from customer
where customer.customer_num
IN (select orders.customer_num from orders)
