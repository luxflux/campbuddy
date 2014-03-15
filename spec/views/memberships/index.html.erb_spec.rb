require 'spec_helper'

describe "memberships/index" do
  before(:each) do
    assign(:memberships, [
      stub_model(Membership,
        :user => stub_model(User, name: 'A user'),
        :group => stub_model(Group, name: 'A group'),
      ),
      stub_model(Membership,
        :user => stub_model(User, name: 'A user'),
        :group => stub_model(Group, name: 'A group'),
      )
    ])
  end

  it "renders a list of memberships" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 'A user', :count => 2
    assert_select "tr>td", :text => 'A group', :count => 2
  end
end
