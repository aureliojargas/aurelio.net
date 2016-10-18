-- qual o usuário que mais emprestou: maria jose e joao

SELECT usuarios.nome, count(emprestimos.cod_usu) qtos_emp
FROM emprestimos, usuarios
WHERE usuarios.cod_usu = emprestimos.cod_usu
GROUP BY emprestimos.cod_usu, nome;
