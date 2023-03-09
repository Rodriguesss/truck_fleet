 README

## Como iniciar o projeto

Antes de tudo, é necessário instalar o Ruby(3.1.2) e o Rails(7.0.3.1) em sua máquina. Você pode seguir as instruções oficiais de instalação do Ruby e do Rails nos seguintes links:

- [Ruby](https://www.ruby-lang.org/pt/documentation/installation/)
- [Rails](https://guides.rubyonrails.org/getting_started.html#creating-a-new-rails-project-installing-rails)

Uma vez que o Ruby e o Rails estejam instalados, siga os seguintes passos para iniciar o projeto:

1. Clone este repositório em sua máquina.
2. Abra o terminal e navegue até o diretório raiz do projeto.
3. Execute o comando `bundle install` para instalar todas as dependências do projeto.
4. Execute o comando `rails db:migrate` para executar as migrações do banco de dados.
5. Execute o comando `rails s` para iniciar a aplicação.

Agora você deve ser capaz de acessar a aplicação em `http://localhost:3000`.

## Como testar os arquivos em request com RSpec

Este projeto utiliza o framework RSpec para testes automatizados. Para executar todos os testes de request, siga os seguintes passos:

1. Abra o terminal e navegue até o diretório raiz do projeto.
2. Execute o comando `rspec spec/requests` para executar todos os testes de request.

Você também pode executar testes individuais adicionando o caminho para o arquivo de teste como um argumento, por exemplo:

`rspec spec/requests/deliveries_controller_spec.rb`

Isso irá executar apenas os testes no arquivo `deliveries_controller_spec.rb`.
