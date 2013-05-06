class UpdateBooks < ActiveRecord::Migration
  def change
      add_column :books, :name, :string
      add_column :users, :full_name, :string
  end

end
