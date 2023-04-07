class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :prefecture
    belongs_to :category
    belongs_to :condition
    belongs_to :shipping_day
    belongs_to :shipping_fee
  
  belongs_to :user
  # has_one :purchase_history
  has_one_attached :image

  validates :image, presence: true
  validates :name, :description, :category_id, :condition_id,:shipping_fee_id, :prefecture_id, :shipping_day_id, presence: true
  validates :price, presence: true, numericality: { less_than: 9999999, message: 'は9999999よりも小さい値で入力してください' }
  validates :price, presence: true, numericality: { greater_than: 299, message: 'は299よりも大きい値で入力してください' }
  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :condition_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_day_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_fee_id, numericality: { other_than: 1 , message: "can't be blank"}

end
