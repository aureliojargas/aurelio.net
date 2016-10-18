
-- quais clientes est�o fora da calif�rnia e
-- t�m pedido, n�o t�m, e quantos por cada

select lname
	from customer
   where state = "CA" 
		AND customer_num 
		IN (select customer_num 
				from orders);

select count(customer_num), lname
	from customer
   where state != "CA" 
		AND customer_num 
		IN (select customer_num 
				from orders)
	group by lname;
