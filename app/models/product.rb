class Product < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true, length: {minimum: 3, maximum: 50}
  validates :price, presence: true
  validates :user_id, presence: true
  
end