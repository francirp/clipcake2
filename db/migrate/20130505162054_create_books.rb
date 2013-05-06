class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :captain_id
      t.integer :recipient_fb_id
      t.string :occasion
      t.date :event_date
      t.date :reminder_1
      t.date :reminder_2
      t.date :final_reminder
      t.date :contribution_deadline
      t.string :book_size
      t.string :invite_message_subject
      t.string :invite_message_body
      t.string :sharing_preference
    end
  end
end
