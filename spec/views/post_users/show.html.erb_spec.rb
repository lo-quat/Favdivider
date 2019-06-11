require 'rails_helper'

RSpec.describe "post_users/show", type: :view do
  before(:each) do
    @post_user = assign(:post_user, PostUser.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
