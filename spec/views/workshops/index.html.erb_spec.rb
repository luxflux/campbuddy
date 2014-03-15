require 'spec_helper'

describe "workshops/index" do
  before(:each) do
    assign(:workshops, [
      stub_model(Workshop,
        :owner => nil,
        :title => "Title",
        :description => "MyText",
        :starts => Time.now - 3.hours,
        :ends => Time.now - 2.hours,
      ),
      stub_model(Workshop,
        :owner => nil,
        :title => "Title",
        :description => "MyText",
        :starts => Time.now + 3.hours,
        :ends => Time.now + 5.hours,
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
