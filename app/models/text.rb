class Text < ActiveRecord::Base
  belongs_to :book
  belongs_to :role
  belongs_to :user
  belongs_to :page
end
