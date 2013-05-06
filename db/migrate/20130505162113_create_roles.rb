class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :book_id
      t.integer :user_id
      t.string :role_type
    end
  end
end
