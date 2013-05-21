class ChangeIntToStringUid < ActiveRecord::Migration
  def change
    change_column :users, :uid, :string
    change_column :friends, :uid, :string
  end
end
