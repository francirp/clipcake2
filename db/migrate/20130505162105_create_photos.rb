class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :page_id
      t.integer :position
      t.string :source_url
      t.string :caption
      t.date :fb_created_date
      t.integer :fb_object_id
      t.boolean :is_picked
    end
  end
end
