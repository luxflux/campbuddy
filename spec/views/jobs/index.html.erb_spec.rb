require 'spec_helper'

describe "jobs/index" do
  before(:each) do
    assign(:jobs, [
      stub_model(Job,
        :name => "Name",
        :description => "MyText",
        :group => stub_model(Group, name: 'A group'),
      ),
      stub_model(Job,
        :name => "Name",
        :description => "MyText",
        :group => stub_model(Group, name: 'Another group'),
      )
    ])
  end

  it "renders a list of jobs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name", :count => 2
    assert_select "tr>td", :text => "MyText", :count => 2
    assert_select "tr>td", :text => 'Another group', :count => 1
    assert_select "tr>td", :text => 'A group', :count => 1
  end
end
