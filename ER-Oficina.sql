-- Desafio Oficina
/*
1 - Mapeamento do esquema ER para o Relacional
2 - Definição do Script SQL para criação do esquema do banco de dados
3 - Persistência de dados para testes
4 - Recuperação de informações com queries SQL

-- Diretrizes
- Não há um mínimo de queries a serem realizadas
- Os tópicos supracitados devem estar presentes nas queries
- Elabore perguntas que podem ser respondidas pelas consultas
- As cláusulas podem estar presentes em mais de uma query
*/
-- drop database oficina_bd;
show databases;
create database if not exists oficina_bd;
use oficina_bd;

-- Criar as tabelas ClientesPF e ClientesPJ
create table ClientPF (
	idClientPF int auto_increment primary key,
	Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11),
    Bdate date,
    Address varchar(255)
);
create table ClientPJ(
	idClientPJ int auto_increment primary key,
    CNPJ char(14),
    RazaoSocial varchar(50),
    Address varchar(255)
);

-- Criar tabela Clientes
create table Clients(
	IdClient int auto_increment primary key,
    idClientPJ int,
    idClientPF int,
    ClientType enum ('PF','PJ') not null,
    CONSTRAINT ck_tipo_cliente CHECK (
        (ClientType = 'PF' AND idClientPJ IS NULL) OR 
        (ClientType = 'PJ' AND idClientPF IS NULL) )
 );
alter table Clients auto_increment = 1;
alter table Clients
    add constraint fk_cliente_pf foreign key (idClientPF) references ClientPF(idClientPF),
    add constraint fk_cliente_pj foreign key (idClientPJ) references ClientPJ(idClientPJ);

-- Criar tabela Veículo
CREATE TABLE Veiculo (
    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa char(7) NOT NULL UNIQUE,
    modelo VARCHAR(45),
    marca VARCHAR(45),
    ano INT,
    idClient INT,
    FOREIGN KEY (idClient) REFERENCES Clients(idClient)
);

-- Criar tabela Peca
CREATE TABLE Peca (
    idPeca INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL,
    preco FLOAT NOT NULL,
    estoque INT NOT NULL
);
-- Criar tabela Mecânico
CREATE TABLE Mecanico (
    idMecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100),
    contato CHAR(11),
    endereco VARCHAR(255)    
);
-- Criar tabela Serviço
CREATE TABLE Servico (
    idServico INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL,
    valor FLOAT NOT NULL
);
-- Criar tabela Order de Serviço
CREATE TABLE OrdemDeServico (
    idOrdem INT AUTO_INCREMENT PRIMARY KEY,
    idVeiculo INT NOT NULL,
    idMecanico INT NOT NULL,
    data_emissao DATE NOT NULL,
    data_conclusao DATE,
    status_os ENUM('Concluido','Em andamento','Cancelado') NOT NULL,
    valor_total FLOAT,
    CONSTRAINT fk_os_veiculo FOREIGN KEY (idVeiculo) REFERENCES Veiculo(idVeiculo),
    CONSTRAINT fk_os_mecanico FOREIGN KEY (idMecanico) REFERENCES Mecanico(idMecanico)
);

-- Criar tabela Relação Peça e Ordem de Serviço
CREATE TABLE Peca_has_Ordem (
    idPeca INT NOT NULL,
    idOrdem INT NOT NULL,
    quantidade INT NOT NULL,
    PRIMARY KEY (idPeca, idOrdem),
    CONSTRAINT fk_po_peca FOREIGN KEY (idPeca) REFERENCES Peca(idPeca),
    CONSTRAINT fk_po_ordem FOREIGN KEY (idOrdem) REFERENCES OrdemDeServico(idOrdem)
);

-- Criar tabela Relação Serviço e Ordem de Serviço
CREATE TABLE Servico_has_Ordem (
    idServico INT NOT NULL,
    idOrdem INT NOT NULL,
    quantidade INT NOT NULL,
    PRIMARY KEY (idServico, idOrdem),
    CONSTRAINT fk_so_servico FOREIGN KEY (idServico) REFERENCES Servico(idServico),
    CONSTRAINT fk_so_ordem FOREIGN KEY (idOrdem) REFERENCES OrdemDeServico(idOrdem)
);

/*
use oficina_bd;
show tables;
use information_schema;
show tables;
desc table_constraints;
desc REFERENTIAL_CONSTRAINTS;
select * from REFERENTIAL_CONSTRAINTS where constraint_schema = 'oficina_bd';
*/

-- Inserção de dados e queries

insert into ClientPF(Fname, Minit, Lname, CPF, Bdate, Address) values
	('Patricio','T','Silva',12346789,'1980-01-05','rua dianopolis 13 , Vila Prudente - Nova São Paulo'),
	('Jorge','B','Kansas',987654321,'1972-05-15','rua das ambulancias 289 , Mooca - Nova São Paulo'),
    ('Bruno','C','Sandolho',45678913,'1986-07-20','avenida sorocabana 24 , Vila Fiori - Nova São Paulo'),
    ('Diego','R','Martins',789123456,'1984-03-04','rua das orquideas 352 , Vila da Vitoria - Nova São Paulo'),
    ('Viviane','M','Winkler',98745631,'2001-12-01','Avenida de Koller 19 , Centro - Nova São Paulo'),
    ('Juliana','I','Bonde',654789123,'2003-08-10','Rua Alameda das Flores 28 , Centro - Nova São Paulo')
;

insert into ClientPJ(CNPJ,RazaoSocial,Address) values
	('12345678000110','Empresa A','Rua dos Cubanos 123, Centro - Nova São Paulo'),
    ('98765432000120','Empresa B','Avenida Brasil 456, Centro - Nova São Paulo'),
    ('56789012000130','Empresa C','Rua Venezuelandia 1313, Vila Margarida - Nova São Paulo'),
    ('23456789000140','Empresa D','Rua dos Jumencios 352, Bairro da Esperança - Nova São Paulo')
;

insert into Clients(idClientPJ,idClientPF,ClientType) values
	(null,'1','PF'),
    (null,'2','PF'),
    (null,'3','PF'),
    (null,'4','PF'),
    (null,'5','PF'),
    (null,'6','PF'),
    ('1',null,'PJ'),
    ('2',null,'PJ'),
    ('3',null,'PJ'),
    ('4',null,'PJ')
;

INSERT INTO Veiculo(placa,modelo,marca,ano,idClient) values
	('ABC1234','Fit','Honda','2003','1'),
    ('QQQ6497','Palio','Fiat','2015','2'),
    ('BKL1324','Dolphin','BYD','2023','3'),
    ('GOO3336','Onix','Chevrolet','2017','4'),
    ('TPG1189','CLK','Mercedes','2022','5'),
    ('SKU0665','X1','BMW','2021','6'),
    ('TTI8555','Fiorino','Fiat','2005','7'),
    ('AFR2300','Strada','Fiat','2000','8'),
    ('PTR7896','Saveiro','Wolkswagen','2009','9'),
    ('LHR2214','Oroch','Renault','2020','10'),
    ('ERP4498','Fiorino','Fiat','2002','10')
;

INSERT INTO Servico(descricao,valormo) values
	('Troca de Óleo',150.00),
    ('Alinhamento e Balanceamento',140.00),
    ('Limpeza de Bico',350.00),
    ('Troca de Amortecedor',100.00),
    ('Manutenção de Freio',200.00)
;

INSERT INTO Peca (descricao,preco,estoque) values
	('Oleo Lubrax',35.00,20),
    ('Filtro de Oleo',15.00,10),
    ('Pastilha Freio',160.00,16),
    ('Amortecedor',350.00,8),
    ('Fluido Arrefecimento',40.00,10)
;

INSERT INTO Mecanico (nome,especialidade,contato,endereco) VALUES
	('Rodolfo','Serviços Gerais','11985947193','Rua Xavantes 46 - Braz'),
    ('Joaquim','Eletrica','11925360055','Rua Timbo 77 - Vila Viva'),
    ('Kleber','Cambio Automatico','11998986311','Rua Dom Bosco 100 - Vila Italiana'),
    ('Wiliam','Suspenções','11988775694','Rua Silverio Almeida 58 - Nova Holambra')
;

INSERT INTO OrdemDeServico(idVeiculo,idMecanico,data_emissao,data_conclusao,status_os,valor_total) VALUES
		(3,1,'2025-01-07','2025-01-07','Concluido',200.00),
        (5,2,'2024-12-16','24-12-19','Concluido',700.00),
        (9,3,'2024-12-30',null,'Em andamento',3800.00),
        (10,4,'2025-01-03',null,'Em andamento',1500.00)
;

-- 
-- Queries criadas para responder outras perguntas de negócios
-- 
-- Quais são os veículos de clientes do tipo "PF" cadastrados na oficina?
SELECT V.placa, V.modelo, V.marca, V.ano FROM Veiculo V
JOIN Clients C ON V.idClient = C.IdClient
WHERE C.ClientType = 'PF';

-- Quais mecânicos possuem "Eletrica" como especialidade?
SELECT nome, contato FROM Mecanico
WHERE especialidade = 'Eletrica';

-- Quais veículos tiveram ordem de serviço por ordem de entrada?
SELECT O.idOrdem, V.placa, O.data_emissao
FROM OrdemDeServico O
JOIN Veiculo V ON O.idVeiculo = V.idVeiculo
ORDER BY O.data_emissao ASC;

-- Quais clientes possuem mais de um veículo registrado na oficina?
SELECT C.IdClient, COUNT(V.idVeiculo) AS total_veiculos
FROM Clients C
JOIN Veiculo V ON C.IdClient = V.idClient
GROUP BY C.IdClient
HAVING total_veiculos > 1;

-- Quais clientes possuem veículos que já realizaram ordens de serviço com status "Concluido"?
SELECT DISTINCT C.IdClient, 
       CASE 
           WHEN C.ClientType = 'PF' THEN CP.Fname 
           ELSE CJ.RazaoSocial 
       END AS Nome_Cliente
FROM Clients C
LEFT JOIN ClientPF CP ON C.idClientPF = CP.idClientPF
LEFT JOIN ClientPJ CJ ON C.idClientPJ = CJ.idClientPJ
JOIN Veiculo V ON C.IdClient = V.idClient
WHERE EXISTS (
    SELECT 1 FROM OrdemDeServico O
    WHERE O.idVeiculo = V.idVeiculo AND O.status_os = 'Concluido'
);
