class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  
  belongs_to :user
  # has_one :purchase_history
  has_one_attached :image

  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
   
end
