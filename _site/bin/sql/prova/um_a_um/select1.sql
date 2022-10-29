-- quantas publicações estão emprestadas

SELECT count(cod_emp)
	FROM emprestimos
	WHERE data_dev IS NULL;
