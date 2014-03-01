require 'spec_helper'

describe "workshops/index" do
  before(:each) do
    assign(:workshops, [
      stub_model(Workshop,
        :owner => nil,
        :title => "Title",
        :description => "MyText"
      ),
      stub_model(Workshop,
        :owner => nil,
        :title => "Title",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of workshops" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
