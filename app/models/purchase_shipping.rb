class PurchaseShipping
  include ActiveModel::Model
  attr_accessor :purchase_history, :postal_code, :prefecture_id, :city, :address, :building, :phone_number, 
                :user_id, :item_id                      

  # ここにバリデーションの処理を書く
  with_options presence: true do
    # validates numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000000, message: 'is invalid'}
    validates :user_id, :item_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  end

  validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}

  def save
    # 各テーブルにデータを保存する処理を書く
    purchase_histories = PurchaseHistory.create(user_id: user_id, item_id: item_id)


    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city,
      house_number: house_number, building: building, phone_number: phone_number, purchase_history_id: purchase_histories.id)

  end
end