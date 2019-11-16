FactoryBot.define do
  factory :tweet1, class: Tweet do
    user_id {1}
    post_user_id {1}
    text {"abcdefg"}
    favorite_count {10}
    is_quote_status {true}
  end
  factory :tweet2, class: Tweet do
    user_id {1}
    post_user_id {1}
    text {"defgffe"}
    favorite_count {5}
  end
  factory :tweet3, class: Tweet do
    user_id {1}
    post_user_id {1}
    text {"abcklmn"}
    favorite_count {9}
    status {1}
  end
end
