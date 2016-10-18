-- quantas publicações estão emprestadas: 4

SELECT count(cod_emp) emprestadas
	FROM emprestimos
	WHERE data_dev IS NULL;


-- quantas publicações não estão emprestadas: 6

SELECT count(cod_emp) nao_emprestadas
FROM emprestimos
WHERE data_dev IS NOT NULL;


-- quais ias publicações que não estão emprestadas
-- mostra o código cod_ite+cod_pub
SELECT cod_ite, cod_pub 
FROM item
WHERE item.cod_ite IN (
	SELECT cod_ite
	FROM emprestimos
	WHERE data_dev
	IS NOT NULL );


-- quantas reservas estão pendentes: 10 
-- (todas as entradas da tabela reservas são reservas pendentes)

SELECT count(cod_res) reservas_pendentes
FROM reservas;


-- qual o usuário que mais emprestou: maria jose e joao

SELECT usuarios.nome, count(emprestimos.cod_usu) qtos_emp
FROM emprestimos, usuarios
WHERE usuarios.cod_usu = emprestimos.cod_usu
GROUP BY emprestimos.cod_usu, nome;

