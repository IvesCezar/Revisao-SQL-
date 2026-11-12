-- Banco do supermercado
CREATE DATABASE mercado_update;
USE mercado_update;
 
CREATE TABLE fornecedor (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  cidade VARCHAR(40) NOT NULL
);
 
-- corredor e atualizado_em podem ficar vazias (NULL)
CREATE TABLE produto (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(60) NOT NULL,
  categoria VARCHAR(20) NOT NULL,
  preco DECIMAL(7,2) NOT NULL,
  estoque INT NOT NULL,
  status VARCHAR(15) NOT NULL,
  corredor VARCHAR(15),
  atualizado_em DATE,
  fornecedor_id INT NOT NULL,
  FOREIGN KEY (fornecedor_id) REFERENCES fornecedor(id)
);
 
INSERT INTO fornecedor (nome, cidade) VALUES
  ('Laticínios Serra Verde', 'Juiz de Fora'),
  ('Grãos do Cerrado', 'Goiânia'),
  ('Bebidas Litoral', 'Santos');
 
INSERT INTO produto
  (nome, categoria, preco, estoque, status, corredor, fornecedor_id)
VALUES
  ('Leite integral 1L', 'Laticínios', 5.49, 120, 'Ativo', 'C1', 1),
  ('Queijo muçarela kg', 'Laticínios', 42.90, 18, 'Ativo', NULL, 1),
  ('Iogurte natural', 'Laticínios', 3.99, 0, 'Ativo', 'C1', 1),
  ('Arroz tipo 1 5kg', 'Mercearia', 27.90, 60, 'Ativo', 'C4', 2),
  ('Feijão carioca 1kg', 'Mercearia', 8.49, 75, 'Ativo', NULL, 2),
  ('Café torrado 500g', 'Mercearia', 18.90, 40, 'Ativo', 'C5', 2),
  ('Suco de uva 1L', 'Bebidas', 12.50, 30, 'Ativo', NULL, 3),
  ('Água mineral 1,5L', 'Bebidas', 2.99, 200, 'Ativo', 'C7', 3);
  
  -- 1 Conferir as tabelas
  
SELECT * FROM fornecedor;
SELECT * FROM produto;

-- 2 Alterar o valor do produto,( o changed ficou =1, quando executei  novamente =0)
UPDATE mercado_update. produto SET preco = '19.90' WHERE (id = '6');
  
  -- 3 Status mudou e preco tambem 
UPDATE mercado_update. produto SET preco = '4.29', STATUS = 'Esgotado'
 WHERE (id = '3');

-- 4 Calculo com o propio valor
UPDATE produto SET estoque = estoque -3
WHERE (id = '4');

-- 5 Varias linhas 
UPDATE produto
SET preco = preco + 0.50
WHERE categoria = 'Bebidas';

-- 6 WHERE com AND. Os Laticínios com estoque maior que 0 e menor que 20 (uma linha  mudou somente)
UPDATE produto SET status = 'repor'
WHERE categoria = 'Laticínios' 
AND estoque >0
AND estoque <20;

-- 7 WHERE com LIKE. Os produtos cujo nome termina em 1L vão para o corredor C7.
UPDATE produto
SET corredor = 'C7'
WHERE nome LIKE '%1L';

-- 8 Porcentagem com ROUND. A Mercearia teve aumento de 8%. Arredonde o preço para 2 casas.
UPDATE produto
SET preco = ROUND(preco * 1.08, 2)
WHERE categoria = 'Mercearia';

-- 9 Texto com CONCAT. A água (id 8) agora é vendida em fardo: acrescente " - fardo 6un" ao fim do nome.
UPDATE produto
SET nome = CONCAT(nome, ' - fardo 6un')
WHERE id = 8;


-- 10 Preencher NULL. Os produtos sem corredor recebem A definir.
UPDATE produto
SET corredor = 'A definir'
WHERE corredor IS NULL;


-- 11 Data de hoje com CURDATE. O fornecedor parou de fabricar o iogurte (id 3): status Inativo e atualizado_em com a data de hoje.
UPDATE produto
SET status = 'Inativo',
    atualizado_em = CURDATE()
WHERE id = 3;


-- 12 ORDER BY e LIMIT. Os 2 produtos com maior estoque ganham 10% de desconto (arredonde para 2 casas).
UPDATE produto
SET preco = ROUND(preco * 0.90, 2)
ORDER BY estoque DESC
LIMIT 2;


-- 13 UPDATE com INNER JOIN. O frete do fornecedor de Goiânia ficou mais caro: os produtos dele ganham 1.00 no preço. Use a cidade do fornecedor, não o id.
UPDATE produto AS p
INNER JOIN fornecedor AS f
ON p.fornecedor_id = f.id
SET p.preco = p.preco + 1.00
WHERE f.cidade = 'Goiânia';



-- 14 Mudar a chave estrangeira. O queijo (id 2) agora vem do fornecedor 2. Depois tente trocar para o fornecedor 7 e anote o erro.
UPDATE produto
SET fornecedor_id = 2
WHERE id = 2;



-- 15 Conferir e refletir. Rode SELECT * FROM produto; e responda em comentários: (a) o que aconteceria com UPDATE produto SET preco = 1.00;? (b) o que está errado em SET status = 'Ativo' AND corredor = 'C1'?
SELECT * FROM produto;
UPDATE produto
SET preco = 1.00;
-- Resposta: todos os produtos da tabela teriam seus preços alterados para R$ 1,00, 

SET status = 'Ativo' AND corredor = 'C1';
-- o erro está na utilização do operador AND dentro do SET nesse caso deve ser utilizado a virgla  ao inves do AND
UPDATE produto
SET status = 'Ativo',
    corredor = 'C1'
WHERE id = 2;
