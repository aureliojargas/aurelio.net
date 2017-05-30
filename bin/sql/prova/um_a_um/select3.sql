-- quantas reservas estão pendentes: 10 
-- (todas as entradas da tabela reservas são reservas pendentes)

SELECT count(cod_res)
FROM reservas;
