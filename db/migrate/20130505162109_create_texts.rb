class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :page_id
      t.string :message
      t.integer :position
      t.string :font_size
      t.string :font_type
      t.string :font_color
    end
  end
end
