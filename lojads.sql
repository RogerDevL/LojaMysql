CREATE DATABASE LojaDs;

USE LojaDs;

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    id_cidade INT
);

CREATE TABLE cidades (
    id_cidade INT AUTO_INCREMENT PRIMARY KEY,
    nome_cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(2) NOT NULL
);

CREATE TABLE fornecedores (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    nome_fornecedor VARCHAR(100) NOT NULL,
    contato VARCHAR(100),
    telefone VARCHAR(15)
);

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(100) NOT NULL
);

CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL,
    id_categoria INT,
    id_fornecedor INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedores(id_fornecedor)
);

CREATE TABLE funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome_funcionario VARCHAR(100) NOT NULL,
    cargo VARCHAR(50),
    salario DECIMAL(10, 2),
    id_departamento INT
);

CREATE TABLE departamentos (
    id_departamento INT AUTO_INCREMENT PRIMARY KEY,
    nome_departamento VARCHAR(100) NOT NULL
);

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_funcionario INT,
    id_produto INT,
    quantidade INT NOT NULL,
    data_pedido DATE NOT NULL,
    id_pagamento INT,
    id_envio INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

CREATE TABLE pagamentos (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    metodo_pagamento VARCHAR(50) NOT NULL
);

CREATE TABLE envios (
    id_envio INT AUTO_INCREMENT PRIMARY KEY,
    data_envio DATE,
    status_envio VARCHAR(50)
);

INSERT INTO cidades (nome_cidade, estado) VALUES 
('São Paulo', 'SP'),
('Rio de Janeiro', 'RJ'),
('Belo Horizonte', 'MG'),
('Curitiba', 'PR');

INSERT INTO clientes (nome, email, telefone, id_cidade) VALUES 
('João Silva', 'joao.silva@email.com', '11912345678', 1),
('Maria Oliveira', 'maria.oliveira@email.com', '21998765432', 2),
('Carlos Pereira', 'carlos.pereira@email.com', '31976543210', 3);

INSERT INTO fornecedores (nome_fornecedor, contato, telefone) VALUES 
('Tech Supplies Ltda', 'Carlos Souza', '1133224455'),
('Distribuidora de Eletrônicos', 'Fernanda Lima', '2122233344');

INSERT INTO categorias (nome_categoria) VALUES 
('Eletrônicos'),
('Informática'),
('Acessórios');

INSERT INTO produtos (nome_produto, preco, estoque, id_categoria, id_fornecedor) VALUES 
('Notebook Dell', 3500.00, 10, 2, 1),
('Smartphone Samsung', 1500.00, 20, 1, 2),
('Teclado Mecânico', 250.00, 15, 3, 1),
('Monitor 24" LG', 800.00, 5, 2, 2);

INSERT INTO departamentos (nome_departamento) VALUES 
('Vendas'),
('Logística'),
('RH');

INSERT INTO funcionarios (nome_funcionario, cargo, salario, id_departamento) VALUES 
('Ana Costa', 'Vendedora', 2500.00, 1),
('Pedro Lima', 'Logística', 2000.00, 2),
('Carla Souza', 'Recursos Humanos', 3000.00, 3);

INSERT INTO pagamentos (metodo_pagamento) VALUES 
('Cartão de Crédito'),
('Boleto Bancário'),
('Transferência Bancária');

INSERT INTO envios (data_envio, status_envio) VALUES 
('2024-09-02', 'Enviado'),
('2024-09-03', 'Pendente'),
('2024-09-04', 'Entregue');

INSERT INTO pedidos (id_cliente, id_funcionario, id_produto, quantidade, data_pedido, id_pagamento, id_envio) VALUES 
(1, 1, 2, 1, '2024-09-01', 1, 1),
(2, 2, 1, 2, '2024-09-02', 2, 2),
(3, 1, 3, 1, '2024-09-03', 3, 3),
(1, 2, 4, 2, '2024-09-04', 1, 1),
(2, 1, 2, 1, '2024-09-05', 2, 3);


-- selecionando os clientes com pedidos
SELECT ped.data_pedido AS DataPedido, ped.quantidade AS QuantidadePedido, ped.id_cliente AS ClienteID, clientes.nome, clientes.email
FROM pedidos AS ped
INNER JOIN clientes ON ped.id_cliente = clientes.id_cliente;

-- pegando pedidos pelo ID
SELECT cli.nome, pedidos.quantidade, pedidos.data_pedido
FROM clientes AS cli
INNER JOIN pedidos ON pedidos.id_cliente = cli.id_cliente
WHERE pedidos.id_cliente = 1;


-- pegando os produtos com preco maior que 500
SELECT pro.nome_produto, pro.preco
FROM produtos AS pro
INNER JOIN produtos ON pro.preco > 500;

-- pegando os produtos com preco maior que 500 com WHERE
SELECT pro.nome_produto, pro.preco
FROM produtos AS pro
WHERE pro.preco > 500;


-- selecionando as cidades correspondentes aos clientes
SELECT cid.nome_cidade, clientes.nome, clientes.email
FROM cidades AS cid
INNER JOIN clientes ON clientes.id_cidade = cid.id_cidade;




-- voce precisa identificar o produto do pedido
-- o funcionario que atendeu nesse pedido
-- o cliente que nao ficou satisfeito
SELECT ped.data_pedido AS DataPedido, ped.quantidade AS QuantidadePedido, 
produtos.nome_produto AS Produto, 
funcionarios.nome_funcionario AS Funcionario, 
clientes.nome AS Nome, clientes.telefone AS Telefone, clientes.email AS Email
FROM pedidos AS ped
INNER JOIN produtos ON ped.id_produto = produtos.id_produto
INNER JOIN funcionarios ON ped.id_pedido = funcionarios.id_funcionario
INNER JOIN clientes ON ped.id_cliente = clientes.id_cliente;

-- selecionando um especifico
-- WHERE clientes.nome = "João Silva";


