class PurchaseShipping
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building, :phone_number,
                :user_id, :item_id                      

  # ここにバリデーションの処理を書く
  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city, :address
  end
  validates :prefecture_id, numericality: {only_integer: true, other_than: 1, message: "can't be blank"}
  validates :phone_number, format: {with: /\A\d{10,11}\z/, message: 'is invalid'}



  def save
    # 各テーブルにデータを保存する処理を書く
    purchase_histories = PurchaseHistory.create(user_id: user_id, item_id: item_id)


    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city,
      address: address, building: building, phone_number: phone_number, purchase_history_id: purchase_histories.id)

  end
end