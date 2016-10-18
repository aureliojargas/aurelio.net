-- quantas publica��es est�o emprestadas: 4

SELECT count(cod_emp) emprestadas
	FROM emprestimos
	WHERE data_dev IS NULL;


-- quantas publica��es n�o est�o emprestadas: 6

SELECT count(cod_emp) nao_emprestadas
FROM emprestimos
WHERE data_dev IS NOT NULL;


-- quais ias publica��es que n�o est�o emprestadas
-- mostra o c�digo cod_ite+cod_pub
SELECT cod_ite, cod_pub 
FROM item
WHERE item.cod_ite IN (
	SELECT cod_ite
	FROM emprestimos
	WHERE data_dev
	IS NOT NULL );


-- quantas reservas est�o pendentes: 10 
-- (todas as entradas da tabela reservas s�o reservas pendentes)

SELECT count(cod_res) reservas_pendentes
FROM reservas;


-- qual o usu�rio que mais emprestou: maria jose e joao

SELECT usuarios.nome, count(emprestimos.cod_usu) qtos_emp
FROM emprestimos, usuarios
WHERE usuarios.cod_usu = emprestimos.cod_usu
GROUP BY emprestimos.cod_usu, nome;

