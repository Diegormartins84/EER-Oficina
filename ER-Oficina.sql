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
    placa VARCHAR(10) NOT NULL UNIQUE,
    modelo VARCHAR(100),
    marca VARCHAR(50),
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
    contato VARCHAR(11),
    endereco VARCHAR(255)    
);
-- Criar tabela Serviço
CREATE TABLE Servico (
    idServico INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL,
    valormo FLOAT NOT NULL
);
-- Criar tabela Order de Serviço
CREATE TABLE Ordem_de_Servico (
    idOrdem INT AUTO_INCREMENT PRIMARY KEY,
    idVeiculo INT NOT NULL,
    idMecanico INT NOT NULL,
    data_emissao DATE NOT NULL,
    data_conclusao DATE,
    status_os VARCHAR(50) NOT NULL,
    valor_total FLOAT,
    FOREIGN KEY (idVeiculo) REFERENCES Veiculo(idVeiculo),
    FOREIGN KEY (idMecanico) REFERENCES Mecanico(idMecanico)
);

-- Criar tabela Relação Peça e Ordem de Serviço
CREATE TABLE Peca_has_Ordem_de_Servico (
    idPeca INT NOT NULL,
    idOrdem INT NOT NULL,
    quantidade INT NOT NULL,
    PRIMARY KEY (idPeca, idOrdem),
    FOREIGN KEY (idPeca) REFERENCES Peca(idPeca),
    FOREIGN KEY (idOrdem) REFERENCES Ordem_de_Servico(idOrdem)
);

-- Criar tabela Relação Serviço e Ordem de Serviço
CREATE TABLE Servico_has_Ordem_de_Servico (
    idServico INT NOT NULL,
    idOrdem INT NOT NULL,
    PRIMARY KEY (idServico, idOrdem),
    FOREIGN KEY (idServico) REFERENCES Servico(idServico),
    FOREIGN KEY (idOrdem) REFERENCES Ordem_de_Servico(idOrdem)
);

