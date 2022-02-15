class ChangeUsersPassword < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :password_degest, :string
    add_column :users, :password_digest, :string
  end
end
