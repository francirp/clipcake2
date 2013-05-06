class User < ActiveRecord::Base
    has_many :books, :through => :roles
    has_many :photos
    has_many :roles
    has_many :texts
    has_many :pages
end
