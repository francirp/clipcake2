class Page < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  belongs_to :role
  has_many :photos
  has_many :texts

  def layout_item_one

  end

end
