FactoryBot.define do
  factory :item do
    name { 'example_item' }
    description { 'example_description' }
    category_id { 1 }
    condition_id { 1 }
    shipping_fee_id { 1 }
    prefecture_id { 1 }
    shipping_day_id { 1 }
    price { 1000 }
    association :user
  end
end
