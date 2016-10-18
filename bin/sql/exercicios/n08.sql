
-- quais os prazos de respostas aos clientes e quais os assuntos mais tratados?

select (res_dtime - call_dtime) prazo_de_tempo, fname nome
from cust_calls, customer
where customer.customer_num = cust_calls.customer_num;

-- quais os assuntos mais tratados
select count(cust_calls.call_code), code_descr
from cust_calls, customer, call_type
where customer.customer_num = cust_calls.customer_num
AND cust_calls.call_code = call_type.call_code
group by cust_calls.call_code,code_descr;

-- prazo médio, mínimo, máximo e total
select avg(res_dtime - call_dtime) media, 
		 min(res_dtime - call_dtime) minimo,
		 max(res_dtime - call_dtime) maximo,
		 sum(res_dtime - call_dtime) somatorio
from cust_calls, customer
where customer.customer_num = cust_calls.customer_num
