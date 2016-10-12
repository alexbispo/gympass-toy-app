require "cpf_cnpj"

class AddIndexUniqueCpfToUsers < ActiveRecord::Migration[5.0]
  def change
    User.all.each do |user|
      user.update!(cpf: CPF.generate)
    end

    add_index :users, :cpf, unique: true
  end
end
