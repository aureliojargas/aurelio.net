
-- quantos e quais clientes est�o fora da calif�rnia:  23
select lname
	from customer
   where state != "CA"
	order by lname;

select count (lname)
	from customer
   where state != "CA";
