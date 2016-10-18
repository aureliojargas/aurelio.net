
-- quais clientes fizeram contato telefônico
select fname
from customer, cust_calls
where customer.customer_num = cust_calls.customer_num
order by fname


-- quantos não obtiveram resposta
select fname
from customer, cust_calls
where customer.customer_num = cust_calls.customer_num
AND cust_calls.res_dtime IS NULL
order by fname
