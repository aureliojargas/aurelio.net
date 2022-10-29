CREATE TABLE item(
	cod_ite		serial,
	cod_pub		integer,
	primary key(cod_ite),
	foreign key(cod_pub) references publicacoes
	);
