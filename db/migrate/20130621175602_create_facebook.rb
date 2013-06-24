class CreateFacebook < ActiveRecord::Migration
  def change
    create_table :facebooks do |t|
      t.integer :user_id
      t.integer :uid
      t.string :name
      t.string :email
      t.string :oauth_token
      t.string :avatar

      t.timestamps
    end
  end
end
