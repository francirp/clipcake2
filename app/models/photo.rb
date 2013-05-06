class Photo < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  belongs_to :role
  belongs_to :page

end
