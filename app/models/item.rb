class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  # ActiveHash アソシエーション
  belongs_to :prefecture, :category, :condition, :shipping_day, :shipping_fee
  
  # 通常のアソシエーション
  belongs_to :user
  # has_one :purchase_history

  # ActiveStorage アソシエーション
  has_one_attached :image

  # バリデーション
  validates :image, :name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is invalid' }
  validates :prefecture_id, :category_id, :condition_id, :shipping_day_id, :shipping_fee_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
end
