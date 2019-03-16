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


# Manual de Desenvolvimento

## Documentação

A documentação de código segue o padrão [Yardoc](https://yardoc.org).

Para gerar a documentação atualizada basta executar o seguinte comando em terminal, na pasta raiz do projeto:

`yard doc && yard server`

Este comando irá gerar os arquivos atualizados e iniciar um webserver para fornecer a documentação como páginas de internet. A documentação poderá ser acessada em http://localhost:8808/docs/index.

## Testes

O framework de teste utilizado nesta aplicação é o Minitest, padrão do Rails, e foi optado por cobrir apenas testes unitários.

Quando efetuar qualquer alteração, certifique-se de estar cobrindo seu código com testes unitários. [Saiba mais neste link](https://guides.rubyonrails.org/testing.html).

Antes de enviar seus códigos para o servidor, execute os testes automatizados com o seguinte comando:

```
rails test -cfp
```

# Manual de Uso da Aplicação

A Magratags permite que sejam adicionadas expressões para serem monitoradas no Twitter.

A cada 10 minutos um processo em background é iniciado para buscar na API do Twitter por cada uma das expressões cadastradas e importar os tweets.

## Controle de acesso

O app foi desenvolvido para ser utilizado em uma intranet, onde todos os usuários pertencem a mesma organização. Deste modo, os dados não são separados por contas de acesso e nem por usuário, ou seja, todo usuário logado possui acesso a tudo.

Ao acessar a Magratags será solicitado login e, caso necessário, o usuário poderá criar um novo cadastro tendo acesso imediato aos dados.

---

***ATENÇÃO:***
*Caso necessite publicar este app na WEB, recomenda-se uma das seguintes opções:*
1. *Remover a opção de cadastro do usuário excluindo o módulo 'registerable' do devise. Deste modo o cadastro de novos usuários só pode ser feito pela área administrativa, com um usuário já autorizado.*
2. *Desenvolver uma funcionalidade para aprovação de novos usuários, de modo que o novo usuário registrado só consiga efetuar login após ser aprovado.*

---

## Timeline

Após efetuar login o usuário é redirecionado para a Timeline, onde poderá visualizar as postagens importadas do twitter em ordem cronológica, sendo as mais recentes por primeiro.

### Filtrar Timeline

No lado esquerdo da tela é possível filtrar os tweets pelo nome de usuário que fez a publicação ou pela expressão vinculada.

#### Por autor

O campo pode ser preenchido com um ou mais usuários do Twitter, podendo ou não conter o caractere "@" no início do nome. Exemplo:

```
@pitagg alfakini @magrathealabs
```

#### Por expressão

Neste campo será possível selecionar uma das expressões pré-cadastradas para visualizar apenas as postagens relacionadas a ela.

## Área administrativa

Através da área administrativa é possível gerenciar os usuários, credenciais e expressões em monitoramento.

### Usuários

Permite incluir, alterar, excluir e exportar os usuários. Adicionar um usuário ele passa a ter acesso imediato a todos os dados e funcionalidades.

### Credenciais

Permite incluir, alterar, excluir e exportar as credenciais de acesso a API do Twitter.

Novas credenciais podem ser obtidas gerando um aplicativos pela [área de desenvolvedor do Twitter](https://developer.twitter.com/en/apps).

### Expressões

Permite incluir, alterar, excluir e exportar as expressões que deseja monitorar no Twitter.

Um expressão pode conter:

* `Palavras-chave`: Informando apenas texto simples;
* `#hashtags`: Informando o texto no formado de *#hashtag*;
* `"expressão exata"`: Informando a expressão entre aspas;

## Monitoramento do Twitter

A ferramenta conta com um serviço de agendamento do Heroku, o [Heroku Scheduler](https://devcenter.heroku.com/articles/scheduler), para iniciar o processo de monitoramento em background.

O processo foi desenvolvido por meio de uma Task em lib/tasks/monitoring.rake.

### Limitações

A API do Twitter possui uma limitação de 15 consultas a cada 15 minutos por aplicativo, portanto, dependendo da quantidade de expressões adicionadas, os limites da API serão atingidos rapidamente.

Para aumentar o limite de consultas, basta criar um novo app no Twitter e adicionar as credenciais pela área administrativa.

### Funcionamento

O monitoramento acontece da seguinte forma:

1. Busca todas as credenciais disponíveis para consulta;
2. Busca todas as expressões que devem ser monitoradas, trazendo primeiro as que estão há mais tempo sem monitorar;
3. Varre a lista de expressões e, para cada expressão, faz uma busca no Twitter e importa os tweets encontrados usando a primeira credencial disponível;
4. Se a API do Twitter retornar um erro indicando que o limite de consultas foi atingido, então o processo continua usando a próxima credencial disponível ou encerra, se não houverem mais credenciais.
