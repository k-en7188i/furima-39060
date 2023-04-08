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
  validates :price, presence: true,
                    numericality: { only_integer: true, less_than: 9_999_999, greater_than: 299, message: 'は299〜9999999の範囲内の半角数字で入力してください' }

  validates :prefecture_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :category_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :condition_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_day_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_fee_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }

  validates :name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id, presence: true
end
