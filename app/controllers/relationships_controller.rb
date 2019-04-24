class RelationshipsController < ApplicationController

  def create
    @relationship = Relationship.new(category_id: 6,tweet_id: 1)#6　と　1 指定で試す
    @relationship.save
  end
end
