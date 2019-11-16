FactoryBot.define do
  factory :user, class: User do
    uid {01234}
    access_token {Faker::Lorem.characters(number: 16)}
    access_token_secret {Faker::Lorem.characters(number: 16)}
    email {"test1@gmail.com"}
    password {"foobar1"}
    name {Faker::Name.name}
  end

  factory :another_user, class: User do
    uid {56789}
    access_token {Faker::Lorem.characters(number: 16)}
    access_token_secret {Faker::Lorem.characters(number: 16)}
    email {"test2@gmail.com"}
    password {"foobar1"}
    name {Faker::Name.name}
  end
end