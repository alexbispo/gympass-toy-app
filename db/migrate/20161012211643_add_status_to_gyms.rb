class AddStatusToGyms < ActiveRecord::Migration[5.0]
  def change
    add_column :gyms, :status, :integer, default: 0
  end
end
