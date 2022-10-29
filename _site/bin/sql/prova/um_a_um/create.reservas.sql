CREATE TABLE reservas(
	cod_res		serial,
	cod_pub		integer,
	cod_usu		integer,
	data_res		date,
	primary key(cod_res),
	foreign key(cod_pub) references publicacoes,
	foreign key(cod_usu) references usuarios
	);
