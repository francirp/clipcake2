class ChangeIntegerTypeUid < ActiveRecord::Migration
  def change
    change_column :friends, :uid, :bigint
    change_column :users, :uid, :bigint
  end

end
