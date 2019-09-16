class RelationshipsController < ApplicationController
  validates :tweet_id, uniqueness: { scope: :category_id }
end
