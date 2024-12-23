## Sistema de Gestão de Oficinas Mecânicas

Este projeto tem como objetivo criar um sistema eficiente para gerenciar as operações de uma oficina mecânica.
O sistema permite cadastrar clientes, veículos, mecânicos e ordens de serviço. 

**Esquema Conceitual:**

O sistema é baseado em um modelo de dados relacional, com as seguintes entidades principais:

* **Cliente:** Cada cliente possui um cadastro com informações pessoais e seus veículos.
* **Veículo:** Associado a um cliente, possui informações como modelo, marca e placa.
* **Mecânico:** Cada mecânico possui um cadastro com informações pessoais e especialidades.
* **Ordem de Serviço (OS):** Representa uma solicitação de serviço, associada a um cliente, veículo e mecânico.
Detalhes como data de abertura, serviços realizados, peças utilizadas e valor total são registrados.
* **Serviço:** Cada serviço possui uma descrição e um valor padrão.
* **Peça:** Cada peça possui uma descrição e um valor.

**Relações:**

* Um cliente pode ter vários veículos.
* Uma OS pertence a um cliente e a um veículo.
* Uma OS pode ter vários serviços e peças.
* Um serviço pode estar em várias OS.
* Uma peça pode estar em várias OS.

**Tecnologias Utilizadas:**

* Banco de dados: MySQL Workbench

**Objetivo:**

O objetivo principal do sistema é automatizar os processos da oficina, desde
o cadastro de clientes até a emissão de notas fiscais. Além disso, o sistema 
visa otimizar a gestão de recursos, como a alocação de mecânicos para as ordens de serviço.
