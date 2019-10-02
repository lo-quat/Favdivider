require "rails_helper"

RSpec.describe PostUsersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/post_users").to route_to("post_users#index")
    end

    it "routes to #show" do
      expect(:get => "/post_users/1").to route_to("post_users#show", :id => "1")
    end
  end
end
