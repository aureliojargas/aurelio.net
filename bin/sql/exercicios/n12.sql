
-- qual o valor maior, menor e m�dio dos itens em estoque

select max(unit_price) preco_max, 
		min(unit_price) preco_min,
		avg(unit_price) preco_med
from stock
