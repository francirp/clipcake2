class Role < ActiveRecord::Base
  belongs_to :book
  has_many :pages
  belongs_to :user
  has_many :photos
  has_many :texts

end
