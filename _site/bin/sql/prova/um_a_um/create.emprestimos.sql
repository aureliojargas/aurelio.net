CREATE TABLE emprestimos(
	cod_emp	serial,
	cod_usu	integer,	
	cod_ite	integer,
	data_emp	date,
	data_dev	date,
	primary key(cod_emp),
	foreign key(cod_usu) references usuarios,
	foreign key(cod_ite) references item
	);
