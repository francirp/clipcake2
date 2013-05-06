class Book < ActiveRecord::Base
  has_many :pages
  has_many :roles
  has_many :photos
  has_many :texts
  has_many :users, :through => :roles
end
