# Revisão SQL — UPDATE e DELETE

Repositório de estudos e prática de **SQL com MySQL**, desenvolvido para revisar comandos de manipulação de dados (DML), relacionamentos entre tabelas e cuidados ao realizar alterações e exclusões em um banco de dados.

Os exercícios utilizam dois cenários práticos: um **supermercado**, para trabalhar atualizações de produtos e fornecedores, e uma **agência de viagens**, para praticar exclusões de reservas e clientes.

## Objetivos

- Praticar comandos `UPDATE` e `DELETE`.
- Aplicar filtros com `WHERE`, `AND`, `LIKE`, `BETWEEN`, `IS NULL` e operadores de comparação.
- Utilizar funções como `ROUND()`, `CONCAT()` e `CURDATE()`.
- Atualizar registros com `ORDER BY` e `LIMIT`.
- Relacionar tabelas com `INNER JOIN`.
- Compreender chaves estrangeiras (Foreign Keys) e integridade referencial.
- Utilizar transações com `START TRANSACTION` e `ROLLBACK`.
- Entender as diferenças entre exclusão lógica e física.

## Estrutura do repositório

| Arquivo | Descrição |
|---|---|
| [Update_revisao_ATV.sql](./Update_revisao_ATV.sql) | Criação do banco de supermercado e exercícios de atualização de produtos e fornecedores. |
| [Revisao_Delete_SQL_.sql](./Revisao_Delete_SQL_.sql) | Criação do banco de agência de viagens e exercícios de exclusão de reservas e clientes. |

## Conteúdo estudado

### 1. UPDATE — Atualização de registros

No arquivo `Update_revisao_ATV.sql`, os exercícios trabalham:

- Atualização de preço e status por identificador.
- Cálculos utilizando o próprio valor da coluna.
- Atualização de vários registros por categoria.
- Condições combinadas com `AND`.
- Busca de texto com `LIKE`.
- Reajuste percentual com `ROUND()`.
- Concatenação de texto com `CONCAT()`.
- Preenchimento de campos nulos com `IS NULL`.
- Atualização de datas com `CURDATE()`.
- Seleção dos maiores estoques com `ORDER BY` e `LIMIT`.
- Atualização relacionada entre tabelas com `INNER JOIN`.
- Alteração de chave estrangeira e observação de restrições.

### 2. DELETE — Exclusão de registros

No arquivo `Revisao_Delete_SQL_.sql`, os exercícios abordam:

- Exclusão de um registro pelo ID.
- Exclusão de vários registros por status.
- Filtros com `WHERE`, `AND`, `LIKE` e `BETWEEN`.
- Identificação de valores nulos com `IS NULL`.
- Exclusão com `ORDER BY` e `LIMIT`.
- Exclusão usando `INNER JOIN`.
- Restrições de chave estrangeira.
- Transações e recuperação de dados com `ROLLBACK`.
- Diferenças entre `DELETE`, `TRUNCATE` e `DROP TABLE`.
- Exclusão lógica: manter o cadastro e alterar o status para inativo.

## Tecnologias e ferramentas

- **MySQL**
- **MySQL Workbench**
- **SQL**

## Como executar os exercícios

1. Clone este repositório:
   ```bash
   git clone https://github.com/IvesCezar/Revisao-SQL-.git
   ```
2. Abra o MySQL Workbench e conecte-se ao seu servidor MySQL.
3. Abra um dos arquivos `.sql` disponíveis no repositório.
4. Execute o script para criar o banco e inserir os dados de exemplo.
5. Pratique os comandos e confira os resultados com consultas `SELECT`.

> **Atenção:** os scripts criam bancos de dados e executam alterações e exclusões. Faça os testes em um ambiente de estudo, confira os registros com `SELECT` antes de usar `UPDATE` ou `DELETE` e tenha cuidado com comandos sem `WHERE`. Para testar `ROLLBACK`, mantenha a operação na mesma conexão e não execute `COMMIT` antes de desfazer a transação.

## Conceitos importantes

- **WHERE:** limita quais registros serão afetados.
- **Changed:** indica quantas linhas foram efetivamente alteradas pelo comando.
- **Foreign Key:** mantém a integridade entre registros relacionados.
- **ROLLBACK:** desfaz alterações ainda não confirmadas em uma transação.
- **Soft Delete:** preserva o registro e altera seu status, em vez de removê-lo fisicamente.

## Sobre o projeto

Este repositório faz parte da minha jornada de aprendizado em banco de dados. A proposta é consolidar os fundamentos de SQL por meio de exercícios práticos, compreender o comportamento dos comandos e desenvolver boas práticas para manipulação segura de dados.

---

**Autor:** [Ives Cezar](https://github.com/IvesCezar)
