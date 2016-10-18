CREATE TABLE usuarios(
	cod_usu		serial,
	nome			char(30),
	endereco		char(50),
	telefone		char(11),
	cidade		char(20),
	estado		char(2),
	primary key(cod_usu)
	);
