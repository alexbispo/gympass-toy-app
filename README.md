# Gympass Toy App

Esta aplicação é uma versão simplificada do Gympass.

## Modelo Entidade Relacionamento (ERD)

![Imagem do ERD do GympassToyApp]
(gympasstoyapp-erd.png)

## Funcionalidades

* **Cadastro de usuários:** A aplicação possui três tipos de usuários, usuário comum, usuário administrador de academia, usuário funcionário da Gympass.
  * Optei por representar todos em um unico modelo, fazendo a distinção entre eles através de um campo chamado _role_.
  * _**role:**_ É um campo do tipo _integer_ no banco de dados tratado como um _enum_ na classe modelo da aplicação.
  * _**User#roles**_ => {"gympass_employee"=>0, "gym_manager"=>1, "regular_end_user"=>2}
