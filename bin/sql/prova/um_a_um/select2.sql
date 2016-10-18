-- quantas publica��es n�o est�o emprestadas: 6

SELECT count(cod_emp)
FROM emprestimos
WHERE data_dev IS NOT NULL;

-- quais publica��es n�o est�o emprestadas
-- mostra o c�digo cod_ite+cod_pub
SELECT cod_ite, cod_pub 
FROM item
WHERE item.cod_ite IN (
	SELECT cod_ite
	FROM emprestimos
	WHERE data_dev
	IS NOT NULL );
