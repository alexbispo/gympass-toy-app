# Gympass Toy App

Esta aplicação é uma versão simplificada do Gympass.

## Modelo Entidade Relacionamento (ERD)

![Imagem do ERD do GympassToyApp]
(gympasstoyapp-erd.png)

## Funcionalidades

### Cadastro de usuários:
  * A aplicação possui três tipos de usuários, usuário comum, usuário administrador de academia, usuário funcionário da Gympass.
  * Optei por representar todos em um unico modelo chamado _User_, fazendo a distinção entre eles através de um campo chamado _role_.
  * _**role:**_ É um campo do tipo _integer_ no banco de dados tratado como um _enum_ na classe _User_ da aplicação.
  * _**User#roles**_ => {"gympass_employee"=>0, "gym_manager"=>1, "regular_end_user"=>2}
  * Um usuário pode ter endereços de casa e do trabalho, portanto optei por representar os endereços em um modelo chamado _Location_ que sempre deve pertencer á um único usuário. A distinção entre os tipos de endereço se dá através do campo _type_of_location_.
  * _**type_of_location:**_ É um campo do tipo _integer_ no banco de dados, tratado como um _enum_ na classe _Location_ da aplicação.
  * _**Location#type_of_locations**_ => {"home"=>0, "work"=>1}
