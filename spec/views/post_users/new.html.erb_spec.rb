require 'rails_helper'

RSpec.describe "post_users/new", type: :view do
  before(:each) do
    assign(:post_user, PostUser.new())
  end

  it "renders new post_user form" do
    render

    assert_select "form[action=?][method=?]", post_users_path, "post" do
    end
  end
end
