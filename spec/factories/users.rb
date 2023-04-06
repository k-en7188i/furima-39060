FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name             { '山田' }
    first_name            { '太郎' }
    last_name_kana        { 'ヤマダ' }
    first_name_kana       { 'タロウ' }
    birth_date            { Date.new(2000, 1, 1) }

    trait :with_last_name do
      last_name { '山田' }
    end

    trait :with_first_name do
      first_name { '太郎' }
    end
  end
end
