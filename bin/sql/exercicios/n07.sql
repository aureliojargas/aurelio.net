
-- quais clientes fizeram contato telef�nico
select fname
from customer, cust_calls
where customer.customer_num = cust_calls.customer_num
order by fname


-- quantos n�o obtiveram resposta
select fname
from customer, cust_calls
where customer.customer_num = cust_calls.customer_num
AND cust_calls.res_dtime IS NULL
order by fname
