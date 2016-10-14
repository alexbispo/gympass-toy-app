# Gympass Toy App

Esta aplicação é uma versão simplificada do Gympass.

## Modelo Entidade Relacionamento (ERD)

![Imagem do ERD do GympassToyApp]
(gympasstoyapp-erd.png)

## Algumas Funcionalidades

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

### Cadastro de academias
  * Conforme os requisitos, uma academia, representada pela classe _Gym_ da aplicação, deve ter uma localização, optei por utilizar o recurso de associção polimórfica do Rails.
  * _Location_ está associada á uma entidade polimórfica que eu chamei de _Localizable_, então defini _User_ e _Gym_ como sendo polimorficamente _Localizables_.
  * Escolhi esta abordagem porque achei que ficaria estranho, ter no modelo _Location_ instancias que apesar de terem um atributo _User_, não pertenceriam a um _User_ e sim a um _Gym_, e vice versa.
  * Em relação aos horários de abertura e fechamento, optei por armazenalos como segundos desde meia noite do dia do cadastro, porque assim basta somá-los com a meia noite do dia corrente para saber o horário exato.

### Listar academias ordenadas pela proximidade da geolocalização atual do usuário
  * Utilizei a _API_ _geolocation_ do _HTML5_, optei por obter a localização do usuário no momento do login, as informações de _latitude_ e _longitude_ ficam salvas na sessão do usuário.
  * Para fazer a _query_ calculando a distancia das academias em relação a um determinado ponto, utilizei a _gem_ _geokit-rails_.

## _GEMs_:
  * _**bootstrap-sass**_: Porque ele facilita a criação de um _layout_ no mínimo aceitável para uma aplicação web, é bastante utilizado pela comunidade, bem documentado. E sinceramente, _layout_ de aplicações não é o meu forte. _SASS_, porque é a sugestão _default_ do _Rails_.
  * _**simple_form**_: Porque ela agiliza a criação de formulários e possui uma boa integração com o _bootstrap_, além de ser a _gem_ mais utilizada para este propósito.
  * _**validators e cpf_cnpj**_: Porque é uma gem que adiciona alguns _validators_ bem comuns no nosso dia a dia, como validação de e-mail, cpf e cnpj, os dois ultimos em conjunto com a _gem_ _cpf_cnpj_.
  * _**bcrypt**_: Porque é a sugestão default do _Rails_ para encriptação de _passwords_.
  * _**pry-rails**_: Porque possibilita usar o _pry_ com o _Rails console_.
  * _**pry-meta**_: Porque agrupa as dependências necessárias para fazer _debug_ com o _pry_.
  * _**rails-erd**_: Porque possibilita geração de diagramas _ERD_ (Modelo Entidade Relacionamento).
  * _**rails-i18n**_: Porque ajuda na internacionalização da aplicação.
  * _**rails-env**_: Porque simplifica a configuração e detecção dos _enviroments_ da aplicação.
  * _**capybara**_: Porque é a _gem_ mais popular para testes de integração em aplicações _Rails_. E é a unica que eu já usei.
  * _**geokit-rails**_: Porque esta _gem_ atendeu prefeitamente a minha necessidade de fazer _querys_ baseadas em _longitude_ e _latitude_ no banco de dados, como ordenar pela academia com localização mais próxima de um determianado ponto. Uma curiosidade é que a forma como eu modelei o sistema ficou bem próxima do sugerido na documentação da _gem_.
  * _**mailcatcher**_: Porque funciona muito bem para testar o envio e recebimento de e-mails da aplicação.

## O que eu faria se tivesse mais tempo
- Faria uma refatoração no código, tendo em vista que o código foi escrito da melhor maneira possível visando a entrega.
- Escreveria mais testes unitários e de integração.
- Implementaria a edição do perfil do usuário.
- Implementaria suporte completo ao inglês.
- Implementaria a edição de academias, possibilitando a inclusão de mais usuários como administradores.
