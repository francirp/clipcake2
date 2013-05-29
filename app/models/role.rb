class Role < ActiveRecord::Base
  attr_accessible :book_id, :role_type, :user_id

  belongs_to :book
  has_many :pages
  belongs_to :user
  has_many :photos
  has_many :texts

end
