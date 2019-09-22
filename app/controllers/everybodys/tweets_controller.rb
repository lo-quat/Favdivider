class Everybodys::TweetsController < Everybodys::Base
  def index
    @tweets = Tweet.all
  end
end
