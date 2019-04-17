FactoryBot.define do
  factory :user, class: User do
    email {"test@gmail.com"}
    password {"foobar"}
  end
  factory :tweet1, class: Tweet do
    user_id {1}
    text {"abcdefg"}
    favorite_count {10}
  end
  factory :tweet2, class: Tweet do
    user_id {1}
    text {"defgabc"}
  end
  factory :tweet3, class: Tweet do
    user_id {1}
    text {"abcklmn"}
    favorite_count {9}
  end
end