-- Banco da agência de viagens
CREATE DATABASE viagens_delete;
USE viagens_delete;
 
-- Clientes (pai): telefone pode ficar vazio
CREATE TABLE cliente (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  cidade VARCHAR(40) NOT NULL,
  telefone VARCHAR(15)
);
 
-- Reservas (filho): cliente_id aponta para cliente(id)
CREATE TABLE reserva (
  id INT AUTO_INCREMENT PRIMARY KEY,
  destino VARCHAR(50) NOT NULL,
  data_viagem DATE NOT NULL,
  valor DECIMAL(8,2) NOT NULL,
  status VARCHAR(15) NOT NULL,
  cliente_id INT NOT NULL,
  FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);
 
INSERT INTO cliente (nome, cidade, telefone) VALUES
  ('Fernanda Alves', 'Fortaleza', '(85) 90000-0001'),
  ('Gustavo Reis', 'Natal', '(84) 90000-0002'),
  ('Helena Moura', 'Fortaleza', '(85) 90000-0003'),
  ('Ivo Teixeira', 'João Pessoa', '(83) 90000-0004'),
  ('Jéssica Lopes', 'Natal', '(84) 90000-0005'),
  ('Kleber Nunes', 'Fortaleza', NULL);
 
INSERT INTO reserva
  (destino, data_viagem, valor, status, cliente_id)
VALUES
  ('Gramado', '2026-07-10', 3200.00, 'Concluída', 1),
  ('Porto de Galinhas', '2026-07-22', 2100.00, 'Concluída', 2),
  ('Bonito', '2026-08-05', 4500.00, 'Cancelada', 3),
  ('Jericoacoara', '2026-08-18', 1800.00, 'Concluída', 4),
  ('Foz do Iguaçu', '2026-09-02', 2900.00, 'Cancelada', 5),
  ('Fernando de Noronha', '2026-09-15', 6800.00, 'Concluída', 1),
  ('Chapada Diamantina', '2026-10-01', 2400.00, 'Concluída', 3),
  ('RESERVA TESTE', '2026-10-05', 0.00, 'Pendente', 2),
  ('Lençóis Maranhenses', '2026-11-20', 3100.00, 'Confirmada', 5),
  ('Lençóis Maranhenses', '2026-11-20', 3100.00, 'Confirmada', 5),
  ('Maragogi', '2026-12-05', 2600.00, 'Pendente', 4),
  ('Paraty', '2026-12-12', 1900.00, 'Confirmada', 2);
  
  
-- 1 Preparar. Desligue o modo seguro e confira as duas tabelas com SELECT *.
SET SQL_SAFE_UPDATES = 0;
SELECT * FROM reserva;
SELECT * FROM cliente;

-- 2 Uma linha pelo id. A reserva 10 foi lançada duas vezes (é igual à 9). Apague a duplicada.
DELETE FROM reserva
WHERE id = 10;

-- 3 Várias linhas. Apague todas as reservas com status Cancelada.
DELETE FROM reserva
WHERE STATUS = 'Cancelada';

-- 4 WHERE com AND. Limpeza do histórico: apague as reservas Concluídas com valor menor que 2500. Quantas linhas? 0 linhas

DELETE FROM reserva
WHERE STATUS = 'Concluida' AND valor < 2.500;

-- 5 WHERE com LIKE. Alguém testou o sistema: apague as reservas com TESTE no destino.
DELETE FROM reserva
WHERE status LIKE 'TESTE%';


-- 6 WHERE com BETWEEN. Apague as reservas com viagem em julho de 2026 (de 2026-07-01 a 2026-07-31).
DELETE FROM reserva
WHERE data_viagem BETWEEN '2026-07-01' AND '2026-07-31';


-- 7 Apagar com IS NULL. Apague os clientes sem telefone.
DELETE FROM cliente
WHERE telefone IS NULL;


-- 8 ORDER BY e LIMIT. Apague só a reserva com a data de viagem mais antiga que ainda está no sistema.
DELETE FROM reserva
ORDER BY data_viagem
LIMIT 1;


-- 9 DELETE com INNER JOIN. A agência fechou a filial de João Pessoa: apague as reservas dos clientes dessa cidade. Use a cidade do cliente, não o id.
DELETE reserva
FROM reserva
INNER JOIN cliente
ON reserva.cliente_id = cliente.id
WHERE cliente.cidade = 'João Pessoa';

-- 10 Chave estrangeira. O cliente Gustavo (id 2) pediu para sair. Tente apagá-lo e anote o erro. Depois apague, na ordem certa, as reservas dele e ele.

DELETE FROM cliente WHERE id = 2; -- (Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`viagens_delete`.`reserva`, CONSTRAINT `reserva_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`))

DELETE reserva
FROM reserva
INNER JOIN cliente
ON reserva.cliente_id = cliente.id
WHERE cliente.cidade = 'João Pessoa';

-- 11 Desfazer com ROLLBACK. Abra uma transação, apague todas as reservas, confira que a tabela ficou vazia e desfaça. Quantas reservas há antes e depois do ROLLBACK?
SELECT COUNT(*) AS total_antes
FROM reserva;
START TRANSACTION;
DELETE FROM reserva;
SELECT COUNT(*) AS total_depois_delete
FROM reserva;
ROLLBACK;
SELECT COUNT(*) AS total_depois_rollback
FROM reserva;

-- 12 DELETE, TRUNCATE ou DROP. Tente TRUNCATE TABLE cliente; e anote o erro. Depois explique num comentário a diferença entre DELETE FROM, TRUNCATE e DROP TABLE.
-- Não permite utilizar WHERE.Não exclui a estrutura da tabela.3. DROP TABLE:Exclui completamente a tabela,incluindo seus registros, colunas e estrutura.O TRUNCATE em cliente apresenta erro porquea tabela possui relacionamento com reservapor meio de uma chave estrangeira.

TRUNCATE TABLE cliente;
DELETE FROM cliente
WHERE cidade = 'João Pessoa';
TRUNCATE TABLE cliente;
DROP TABLE cliente;


-- 13 Conferir e refletir. Rode SELECT * nas duas tabelas. Responda num comentário: por que muitas empresas, em vez de apagar um cliente, só mudam um campo como status = 'Inativo'?
SELECT * FROM cliente;
SELECT * FROM reserva;

-- possibilita reativar o cliente futuramente,caso ele volte a utilizar o serviço.
UPDATE cliente
SET status = 'Inativo'
WHERE id = 1;
