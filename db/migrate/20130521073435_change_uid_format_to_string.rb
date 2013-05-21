class ChangeUidFormatToString < ActiveRecord::Migration
  def change
    change_column :books, :recipient_fb_id, :string
    change_column :photos, :fb_object_id, :string
    change_column :users, :facebook_id, :string
  end
end
