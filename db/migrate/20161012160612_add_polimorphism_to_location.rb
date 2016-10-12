class AddPolimorphismToLocation < ActiveRecord::Migration[5.0]
  def up
    User.destroy_all
    remove_column :locations, :user_id
    add_column    :locations, :localizable_id, :integer
    add_column    :locations, :localizable_type, :string
  end

  def down
    add_column    :locations, :user_id, :integer
    remove_column :locations, :localizable_id
    remove_column :locations, :localizable_type
  end
end
