
-- quais itens em estoque não foram vendidos

select stock.manu_code
from stock
where stock.manu_code
NOT IN (select unique items.manu_code
			from items, orders
			where items.order_num = orders.order_num)
