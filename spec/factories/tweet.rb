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
    text {"defgffe"}
    favorite_count {5}
  end
  factory :tweet3, class: Tweet do
    user_id {1}
    text {"abcklmn"}
    favorite_count {9}
  end
  factory :category, class: Category do
    name {"test"}
    user_id {1}
  end

  factory :relationship, class: Relationship do
    tweet_id {1}
    category_id {1}
  end
end
