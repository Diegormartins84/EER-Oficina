## Sistema de Gestão de Oficinas Mecânicas

O objetivo principal do banco de dados é estruturar de forma eficiente os dados relacionados à oficina mecânica, incluindo informações sobre clientes (pessoas físicas e jurídicas), veículos, mecânicos, peças, serviços e ordens de serviço.
O banco de dados facilita o gerenciamento das operações e oferece uma base sólida para desenvolvimento de sistemas e aplicações futuras. 

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

**Banco de Dados**

* Clientes (PF e PJ): Estruturados para suportar clientes físicos e jurídicos, com campos e regras de integridade específicos.
* Veículos: Associados diretamente aos clientes, permitindo que um cliente tenha múltiplos veículos registrados.
* Mecânicos: Registro de informações sobre os profissionais responsáveis pela execução dos serviços.
* Peças: Controle de estoque, incluindo descrição, preço e quantidade disponível.
* Serviços: Cadastro de serviços oferecidos pela oficina, com descrição e valores.
* Ordens de Serviço: Estrutura para registrar serviços realizados e peças utilizadas, vinculadas aos veículos e mecânicos responsáveis.

**Tecnologias Utilizadas:**

* Banco de dados: MySQL
* Ferramentas de Desenvolvimento: MySQL Workbench

**Objetivo:**

O objetivo principal do sistema é automatizar os processos da oficina, desde o cadastro de clientes até a emissão de notas fiscais. Além disso, o sistema visa otimizar a gestão de recursos, como a alocação de mecânicos para as ordens de serviço.
