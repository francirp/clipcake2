class ChangeDateFormatInFriendsTable < ActiveRecord::Migration
  def self.up
   change_column :friends, :uid, :bigint
  end

  def self.down
   change_column :friends, :uid, :integer
  end
end
