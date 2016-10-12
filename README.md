# Gympass Toy App

Esta aplicação é uma versão simplificada do Gympass.

## Modelo Entidade Relacionamento (ERD)

![Imagem do ERD do GympassToyApp]
(gympasstoyapp-erd.png)

## Funcionalidades

### Cadastro de usuários:
  * A aplicação possui três tipos de usuários, usuário comum, usuário administrador de academia, usuário funcionário da Gympass.
  * Optei por representar todos em um unico modelo chamado _User_, fazendo a distinção entre eles através de um campo chamado _role_. Este campo também é utilizado para tratar a autorização do usuário para fazer algumas ações na aplicação.
  * _**role**_: É um campo do tipo _integer_ no banco de dados tratado como um _enum_ na classe _User_ da aplicação.
  * _**User#roles**_ => {"gympass_employee"=>0, "gym_manager"=>1, "regular_end_user"=>2}
  * Um usuário pode ter endereços de casa e do trabalho, portanto optei por representar os endereços em um modelo chamado _Location_ que sempre deve pertencer á um único usuário. A distinção entre os tipos de endereço se dá através do campo _type_of_location_.
  * _**type_of_location**_: É um campo do tipo _integer_ no banco de dados, tratado como um _enum_ na classe _Location_ da aplicação.
  * _**Location#type_of_locations**_ => {"home"=>0, "work"=>1}

### Autenticação
  * Optei por implementar a autenticação, ao invés de utilizar alguma _gem_ para esse propósito. Porque os requisitos da aplicação exigem uma autenticação simples, em outras palavras, não quis "usar um canhão para matar uma formiga".

## _GEMs_:
  * _**bootstrap-sass**_: Porque ele facilita a criação de um _layout_ no mínimo aceitável para uma aplicação web, é bastante utilizado pela comunidade, bem documentado. E sinceramente, _layout_ de aplicações não é o meu forte. _SASS_, porque é a sugestão _default_ do _Rails_.
  * _**simple_form**_: Porque ela agiliza a criação de formulários e possui uma boa integração com o _bootstrap_, além de ser a _gem_ mais utilizada para este propósito.
  * _**validators e cpf_cnpj**_: Porque é uma gem que adiciona alguns _validators_ bem comuns no nosso dia a dia, como validação de e-mail, cpf e cnpj, os dois ultimos em conjunto com a _gem_ _cpf_cnpj_.
  * _**bcrypt**_: Porque é a sugestão default do _Rails_ para encriptação de _passwords_.
  * _**pry-rails**_: Porque possibilita usar o _pry_ com o _Rails console_.
  * _**pry-meta**_: Porque agrupa as dependências necessárias para utilizar o _debug_ com o _pry_.
  * _**rails-erd**_: Para geração de diagramas _ERDs_ (Modelo Entidade Relacionamento).
