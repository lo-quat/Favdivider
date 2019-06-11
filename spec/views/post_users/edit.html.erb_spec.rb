require 'rails_helper'

RSpec.describe "post_users/edit", type: :view do
  before(:each) do
    @post_user = assign(:post_user, PostUser.create!())
  end

  it "renders the edit post_user form" do
    render

    assert_select "form[action=?][method=?]", post_user_path(@post_user), "post" do
    end
  end
end
