
-- quantos e quais clientes estão fora da califórnia:  23
select lname
	from customer
   where state != "CA"
	order by lname;

select count (lname)
	from customer
   where state != "CA";
