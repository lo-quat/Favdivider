class RelationshipsController < ApplicationController

  def create
    relationship = Relationship.new(category_id: params[:relationship][:category],
                                    tweet_id: params[:relationship][:tweet_id])
    relationship.save
    redirect_to edit_tweet_url(params[:relationship][:tweet_id])
  end
end
