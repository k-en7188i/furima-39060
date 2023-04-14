require 'rails_helper'

RSpec.describe PurchaseShipping, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_shipping = FactoryBot.build(:purchase_shipping, user_id: user.id, item_id: item.id)
    sleep 0.1
  end

  context '内容に問題ない場合' do
    it 'すべての情報が正しく入力されていれば保存できること' do
      expect(@purchase_shipping).to be_valid
    end

    it '建物名は任意であること' do
      @purchase_shipping.building = ''
      expect(@purchase_shipping).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it '郵便番号が必須であること' do
      @purchase_shipping.postal_code = ''
      @purchase_shipping.valid?
      expect(@purchase_shipping.errors.full_messages).to include("Postal code can't be blank")
    end

    it '郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと' do
      @purchase_shipping.postal_code = '1234567'
      @purchase_shipping.valid?
      expect(@purchase_shipping.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end

    it '都道府県が必須であること' do
      @purchase_shipping.prefecture_id = ''
      @purchase_shipping.valid?
      expect(@purchase_shipping.errors.full_messages).to include("Prefecture can't be blank")
    end

    it '市区町村が必須であること' do
      @purchase_shipping.city = ''
      @purchase_shipping.valid?
      expect(@purchase_shipping.errors.full_messages).to include("City can't be blank")
    end

    it '番地が必須であること' do
      @purchase_shipping.address = ''
      @purchase_shipping.valid?
      expect(@purchase_shipping.errors.full_messages).to include("Address can't be blank")
    end

    it '電話番号が必須であること' do
      @purchase_shipping.phone_number = ''
      @purchase_shipping.valid?
      expect(@purchase_shipping.errors.full_messages).to include("Phone number is invalid")
    end

    it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと' do
      @purchase_shipping.phone_number = '090-1234-5678'
      @purchase_shipping.valid?
      expect(@purchase_shipping.errors.full_messages).to include('Phone number is invalid')
    end
  end
end

