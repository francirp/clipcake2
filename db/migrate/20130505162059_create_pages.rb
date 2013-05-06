class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :book_id
      t.integer :user_id
      t.string :layout
      t.string :background_color
      t.string :background_image_url
    end
  end
end
