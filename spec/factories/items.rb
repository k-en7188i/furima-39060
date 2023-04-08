FactoryBot.define do
  factory :item do
    name { 'example_item' }
    description { 'example_description' }
    category_id { 2 }
    condition_id { 2 }
    shipping_fee_id { 2 }
    prefecture_id { 2 }
    shipping_day_id { 2 }
    price { 1000 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/icon.png'), filename: 'icon.png')
    end
  end
end