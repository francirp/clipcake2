class ChangeIntegerFormatInFriendsTable < ActiveRecord::Migration

  def change
    change_column :friends, :uid, :bigint
  end

end
