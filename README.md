# Desafio programação - para vaga desenvolvedor

Por favor leiam este documento do começo ao fim, com muita atenção.
O intuito deste teste é avaliar seus conhecimentos técnicos em programação.
O teste consiste em parsear [este arquivo de texto(CNAB)](https://github.com/ByCodersTec/desafio-ruby-on-rails/blob/master/CNAB.txt) e salvar suas informações(transações financeiras) em uma base de dados a critério do candidato.
Este desafio deve ser feito por você em sua casa. Gaste o tempo que você quiser, porém normalmente você não deve precisar de mais do que algumas horas.

# Instruções de entrega do desafio

1. Primeiro, faça um fork deste projeto para sua conta no Github (crie uma se você não possuir).
2. Em seguida, implemente o projeto tal qual descrito abaixo, em seu clone local.
3. Por fim, envie via email o projeto ou o fork/link do projeto para seu contato Bycoders_ com cópia para rh@bycoders.com.br.

# Descrição do projeto

Você recebeu um arquivo CNAB com os dados das movimentações finanaceira de várias lojas.
Precisamos criar uma maneira para que estes dados sejam importados para um banco de dados.

Sua tarefa é criar uma interface web que aceite upload do [arquivo CNAB](https://github.com/ByCodersTec/desafio-ruby-on-rails/blob/master/CNAB.txt), normalize os dados e armazene-os em um banco de dados relacional e exiba essas informações em tela.

**Sua aplicação web DEVE:**

1. Ter uma tela (via um formulário) para fazer o upload do arquivo(pontos extras se não usar um popular CSS Framework )
2. Interpretar ("parsear") o arquivo recebido, normalizar os dados, e salvar corretamente a informação em um banco de dados relacional, **se atente as documentações** que estão logo abaixo.
3. Exibir uma lista das operações importadas por lojas, e nesta lista deve conter um totalizador do saldo em conta
4. Ser escrita na sua linguagem de programação de preferência
5. Ser simples de configurar e rodar, funcionando em ambiente compatível com Unix (Linux ou Mac OS X). Ela deve utilizar apenas linguagens e bibliotecas livres ou gratuitas.
6. Git com commits atomicos e bem descritos
7. PostgreSQL, MySQL ou SQL Server
8. Ter testes automatizados
9. Docker compose (Pontos extras se utilizar)
10. Readme file descrevendo bem o projeto e seu setup
11. Incluir informação descrevendo como consumir o endpoint da API

**Sua aplicação web não precisa:**

1. Lidar com autenticação ou autorização (pontos extras se ela fizer, mais pontos extras se a autenticação for feita via OAuth).
2. Ser escrita usando algum framework específico (mas não há nada errado em usá-los também, use o que achar melhor).
3. Documentação da api.(Será um diferencial e pontos extras se fizer)

# Documentação do CNAB

| Descrição do campo  | Inicio | Fim | Tamanho | Comentário
| ------------- | ------------- | -----| ---- | ------
| Tipo  | 1  | 1 | 1 | Tipo da transação
| Data  | 2  | 9 | 8 | Data da ocorrência
| Valor | 10 | 19 | 10 | Valor da movimentação. *Obs.* O valor encontrado no arquivo precisa ser divido por cem(valor / 100.00) para normalizá-lo.
| CPF | 20 | 30 | 11 | CPF do beneficiário
| Cartão | 31 | 42 | 12 | Cartão utilizado na transação 
| Hora  | 43 | 48 | 6 | Hora da ocorrência atendendo ao fuso de UTC-3
| Dono da loja | 49 | 62 | 14 | Nome do representante da loja
| Nome loja | 63 | 81 | 19 | Nome da loja

# Documentação sobre os tipos das transações

| Tipo | Descrição | Natureza | Sinal |
| ---- | -------- | --------- | ----- |
| 1 | Débito | Entrada | + |
| 2 | Boleto | Saída | - |
| 3 | Financiamento | Saída | - |
| 4 | Crédito | Entrada | + |
| 5 | Recebimento Empréstimo | Entrada | + |
| 6 | Vendas | Entrada | + |
| 7 | Recebimento TED | Entrada | + |
| 8 | Recebimento DOC | Entrada | + |
| 9 | Aluguel | Saída | - |

# Avaliação

Seu projeto será avaliado de acordo com os seguintes critérios.

1. Sua aplicação preenche os requerimentos básicos?
2. Você documentou a maneira de configurar o ambiente e rodar sua aplicação?
3. Você seguiu as instruções de envio do desafio?
4. Qualidade e cobertura dos testes unitários.

Adicionalmente, tentaremos verificar a sua familiarização com as bibliotecas padrões (standard libs), bem como sua experiência com programação orientada a objetos a partir da estrutura de seu projeto.

# Referência

Este desafio foi baseado neste outro desafio: https://github.com/lschallenges/data-engineering

---

Boa sorte!
# RESULTADO
## INFORMAÇÃO/INSTALAÇÃO

Este projeto tem como finalidade o processamento de remessa de logistas de acordo com as normas do CNAB.
O objetivo é digitalizar a emissão e a baixa dos pagamentos, de forma que os dados sejam preenchidos automaticamente dentro de um padrão.

Tecnologias utilizadas:
* Ruby 3.2.1
* Rails 7.0.4.3 (api)
* React 18.2.0
* PostgreSQL Stable
* Docker/Compose 24.0.0

## Preparação de como configura este projeto ? 🔨
OBS: Para os requisitos nescessario para executa esse projeto é preciso do docker/docker-compose, nas versões mais atuais.  Dependendo da versão de esta instalado em seu equipamento o comando de ação muda versões mais antigas 2022 estão operando com a sintaxe
```docker-compose ```a mais atual é ```docker compose ```. 

## Setup 
Na raiz do projeto desafio-dev execute:
Para instala e configura as imagens e containers 
```shell
docker compose build
```
Levanta os servidores
```shell
docker compose up
```
Configurando o banco de dados
```shell
docker compose run --rm cnab-api rails db:drop db:create db:migrate db:seed
```
Acesse [localhost:3000](localhost:3000) Para visualiza a ir a de login ou Realize um Cadastro usando esse link http://localhost:3000/signup

## Consumindo os endpoint da API (CNAB-API)
Nota: esta api se encontra preparada para versionamento. (plus)
### Rotas Auth

* POST http://localhost:3030/api/auth/sign_in (LOGIN)

* POST http://localhost:3030/api/v1/veiculos (CADASTRO DE USUÁRIO)

### Rotas users

* GET http://localhost:3030/api/myaccount/profile (PERFIL DO USUPARIO/SESSÃO)

* POST http://localhost:3030/api/myaccount/profile (ATUALIZA O DO USUARIO)(PLUS)

### Rotas CNAB

* POST http://localhost:3030/api/cnabs/import (IMPORTAÇÃO DO ARQUIVO CNAB)
* GET http://localhost:3030/api/cnabs (LISTA AS CNAB)
* DELETE http://localhost:3030/api/cnabs (DELETA TODAS AS CNAB DO USUÁRIO)

### Autenticação (plus)
* Após o login e necessário envia via headers o 
Authorization: Bearer <your_token>

#### login:
```POST localhost:3030/api/auth/sign_in```
```json
{
	"email": "test@gmail.com",
	"password": "12345678"
}
```
resposta:
```json
{
	"data": {
		"email": "test@test.com",
		"provider": "email",
		"uid": "test@test.com",
		"id": 2,
		"allow_password_change": false
	}
}
```
#### Cadastro:
```POST localhost:3030/api/auth```
```json
{
  "email": "test@gmail.com",
  "password": "12345678",
  "password_confirmation": "12345678"
}
```
resposta:
```json
{
	"status": "success",
	"data": {
		"id": 1,
		"provider": "email",
		"uid": "test@gmail.com",
		"allow_password_change": false,
		"email": "test@gmail.com",
		"created_at": "2023-05-22T10:48:54.580-04:00",
		"updated_at": "2023-05-22T10:48:54.639-04:00"
	}
}
```
### User
#### atualiza perfil (email, senha)
```PUT localhost:3030/api/myaccount/profile```
```json
{
  "email": "test@gmail.com",
  "password": "12345678",
  "password_confirmation": "12345678"
}
```
resposta:
```json
{
	"message": "Perfil atualizado."
}
```
#### consulta perfil/session
```GET localhost:3030/api/myaccount/profile```
```json
{
  "email": "test@gmail.com",
  "password": "12345678",
  "password_confirmation": "12345678"
}
```
resposta:
```json
{
	"data": {
		"id": 1,
		"provider": "email",
		"uid": "test@gmail.com",
		"allow_password_change": false,
		"email": "test@gmail.com",
		"created_at": "2023-05-22T10:48:54.580-04:00",
		"updated_at": "2023-05-22T10:49:16.968-04:00"
	}
}
```
### CNAB
#### lista:

```GET localhost:3030/api/cnabs```
```json
[
	{
		"id": 337,
		"type_cnabs": "Financiamento",
		"date_occurrence": "01/03/2019",
		"value": "142.0",
		"card": 4753,
		"hours": "153453",
		"deal": {
			"id": 3,
			"type_transaction": 3,
			"description": "Financiamento",
			"nature": "Saída",
			"signal": "-"
		},
		"user": {
			"id": 2,
			"provider": "email",
			"uid": "teste@test.com",
			"allow_password_change": false,
			"email": "teste@test.com",
			"created_at": "2023-05-22T11:08:40.547-04:00",
			"updated_at": "2023-05-23T00:37:27.506-04:00"
		},
		"store": {
			"id": 1,
			"store_owner": "JOÃO MACEDO",
			"cpf": "09620676017",
			"store_name": "BAR DO JOÃO",
			"balance_total": "-102.0"
		}
	},
	{
		"id": 338,
		"type_cnabs": "Recebimento Empréstimo",
		"date_occurrence": "01/03/2019",
		"value": "132.0",
		"card": 3123,
		"hours": "145607",
		"deal": {
			"id": 5,
			"type_transaction": 5,
			"description": "Recebimento Empréstimo",
			"nature": "Entrada",
			"signal": "+"
		},
		"user": {
			"id": 2,
			"provider": "email",
			"uid": "teste@test.com",
			"allow_password_change": false,
			"email": "teste@test.com",
			"created_at": "2023-05-22T11:08:40.547-04:00",
			"updated_at": "2023-05-23T00:37:27.506-04:00"
		},
		"store": {
			"id": 2,
			"store_owner": "MARIA JOSEFINA",
			"cpf": "55641815063",
			"store_name": "LOJA DO Ó - MATRIZ",
			"balance_total": "382.32"
		}
	},
	{
		"id": 339,
		"type_cnabs": "Financiamento",
		"date_occurrence": "01/03/2019",
		"value": "122.0",
		"card": 6777,
		"hours": "172712",
		"deal": {
			"id": 3,
			"type_transaction": 3,
			"description": "Financiamento",
			"nature": "Saída",
			"signal": "-"
		},
		"user": {
			"id": 2,
			"provider": "email",
			"uid": "teste@test.com",
			"allow_password_change": false,
			"email": "teste@test.com",
			"created_at": "2023-05-22T11:08:40.547-04:00",
			"updated_at": "2023-05-23T00:37:27.506-04:00"
		},
		"store": {
			"id": 3,
			"store_owner": "MARCOS PEREIRA",
			"cpf": "84515254073",
			"store_name": "MERCADO DA AVENIDA",
			"balance_total": "489.2"
		}
	},
	{
		"id": 344,
		"type_cnabs": "Financiamento",
		"date_occurrence": "01/03/2019",
		"value": "602.0",
		"card": 6777,
		"hours": "172712",
		"deal": {
			"id": 3,
			"type_transaction": 3,
			"description": "Financiamento",
			"nature": "Saída",
			"signal": "-"
		},
		"user": {
			"id": 2,
			"provider": "email",
			"uid": "teste@test.com",
			"allow_password_change": false,
			"email": "teste@test.com",
			"created_at": "2023-05-22T11:08:40.547-04:00",
			"updated_at": "2023-05-23T00:37:27.506-04:00"
		},
		"store": {
			"id": 4,
			"store_owner": "JOSÉ COSTA",
			"cpf": "23270298056",
			"store_name": "MERCEARIA 3 IRMÃOS",
			"balance_total": "-7023.0"
		}
	}
]
```

#### upload:
```POST localhost:3030/api/cnabs/import```
```json
{
  "file": "txt",
}
```
resposta:
```json
{
	"message": "CNAB importada com sucesso!",
	"status": true
}
```
#### deleta cnab do usuário logado:
```DELETE localhost:3030/api/cnabs```
```json
{
  "email": "test@gmail.com",
  "password": "12345678",
  "password_confirmation": "12345678"
}
```
resposta:
```json
{
	"message": "Removido com sucesso! 21 registros"
}
```
## Testes 

Configurando o banco de dados de teste

prepara a tabela Deal (transações)
```shell
docker compose run --rm cnab-api rails ENVIROMENT=test db:seed
```
Executando todos os testes
```shell
docker compose run --rm cnab-api rspec
```
## Telas
LOGIN
![LOGIN](login.jpeg)
REGISTER
![REGISTER](register.jpeg)
HOME
![HOME](home.jpeg)
### Fim Obrigado! :D 🚀
