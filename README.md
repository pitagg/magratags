# Magratags
Monitoramento de hashtags e palavras-chave no Twitter.

## Exemplo
Há um exemplo desta aplicação rodando em https://magratags.herokuapp.com.

---

***ATENÇÃO:***
*Este projeto foi desenvolvido apenas para fins de estudo, portanto  não conta com um bom controle de acessos e não se trata de uma aplicação estável para uso profissional.
Use por sua conta e risco.*

---


## Pré-requisitos
```
Ruby 2.5.1
Rails 5.0.7
PostgreSQL ~> 9.5
```
Obs.: Há um campo do tipo JSON (do postgre) na tabela `posts`.


## Configuração

Após fazer o fork e clonar o repositório em ambiente de desenvolvimento, será necessário configurar o acesso ao banco de dados.

Crie o arquivo `config/database.yml` com o seguinte conteúdo:

```
development:
  adapter: postgresql
  encoding: utf8
  database: magratags_development
  username: [USER]
  password: [PASSWORD]

test:
  adapter: postgresql
  encoding: utf8
  database: magratags_test
  username: [USER]
  password: [PASSWORD]
```

Em seguida basta criar o banco de dados e rodar as migrações:

```
$ rake db:create
$ rake db:migrate
```

Agora é só inicializar o web server...

```
$ rails server -p 3000
```

e acessar aplicação em http://localhost:3000.
