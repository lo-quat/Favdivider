FactoryBot.define do
  factory :category do
    name {Faker::Lorem.characters(number: 8)}
    user_id {1}
  end
end