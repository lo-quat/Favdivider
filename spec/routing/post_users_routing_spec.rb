require "rails_helper"

RSpec.describe PostUsersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/post_users").to route_to("post_users#index")
    end

    it "routes to #new" do
      expect(:get => "/post_users/new").to route_to("post_users#new")
    end

    it "routes to #show" do
      expect(:get => "/post_users/1").to route_to("post_users#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/post_users/1/edit").to route_to("post_users#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/post_users").to route_to("post_users#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/post_users/1").to route_to("post_users#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/post_users/1").to route_to("post_users#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/post_users/1").to route_to("post_users#destroy", :id => "1")
    end
  end
end
