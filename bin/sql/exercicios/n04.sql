
-- quantos cliente N�O possuem pedido e quais s�o: 11
select lname
from customer
where customer.customer_num
NOT IN (select orders.customer_num from orders)
order by lname;

select count(lname)
from customer
where customer.customer_num
NOT IN (select orders.customer_num from orders)
