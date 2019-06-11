require 'rails_helper'

RSpec.describe "post_users/index", type: :view do
  before(:each) do
    assign(:post_users, [
      PostUser.create!(),
      PostUser.create!()
    ])
  end

  it "renders a list of post_users" do
    render
  end
end
