class RelationshipsController < ApplicationController

  def create
    @relationship = Relationship.new(category_id: params[:category],tweet_id: params[:tweet_id])
    @relationship.save
  end
end
