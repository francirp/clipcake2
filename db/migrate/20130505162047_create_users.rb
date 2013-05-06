class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password
      t.string :billing_address
      t.string :billing_city
      t.string :billing_state
      t.string :billing_phone
      t.string :shipping_address
      t.string :shipping_city
      t.string :shipping_state
      t.string :shipping_phone
      t.string :access_token
      t.integer :facebook_id
      t.boolean :is_activated
    end
  end
end
