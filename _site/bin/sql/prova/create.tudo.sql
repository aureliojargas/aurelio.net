CREATE database prova;

CREATE TABLE usuarios(
	cod_usu		serial,
	nome			char(30),
	endereco		char(50),
	telefone		char(11),
	cidade		char(20),
	estado		char(2),
	primary key(cod_usu)
	);

CREATE TABLE publicacoes(
	cod_pub	serial,
	titulo	char(25),
	autor		char(25),
	editora	char(20),
	primary key(cod_pub)
	);

CREATE TABLE item(
	cod_ite		serial,
	cod_pub		integer,
	primary key(cod_ite),
	foreign key(cod_pub) references publicacoes
	);

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

CREATE TABLE reservas(
	cod_res		serial,
	cod_pub		integer,
	cod_usu		integer,
	data_res		date,
	primary key(cod_res),
	foreign key(cod_pub) references publicacoes,
	foreign key(cod_usu) references usuarios
	);
