require 'spec_helper'

describe "memberships/show" do
  before(:each) do
    @membership = assign(:membership, stub_model(Membership,
      :user => nil,
      :group => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
  end
end
