require 'rails_helper'

RSpec.describe "PostUsers", type: :request do
  describe "GET /post_users" do
    it "works! (now write some real specs)" do
      get post_users_path
      expect(response).to have_http_status(200)
    end
  end
end
