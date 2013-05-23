class AddAvatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string, default: "http://www.gravatar.com/avatar/8eac184149444324b77e478ff097386a?size=300&default=https://assets.github.com/images/gravatars/gravatar-140.png"
  end
end
