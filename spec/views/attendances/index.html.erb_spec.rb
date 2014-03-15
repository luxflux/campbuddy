require 'spec_helper'

describe "attendances/index" do
  before(:each) do
    assign(:attendances, [
      stub_model(Attendance,
        :user => stub_model(User, email: "meil@domain.ch", name: "Andreas"),
        :workshop => stub_model(Workshop, :owner => nil, :title => "Title", :description => "MyText", :starts => Time.now - 3.hours, :ends => Time.now - 2.hours)
      ),
      stub_model(Attendance,
        :user => stub_model(User, email: "muil@domain.ch", name: "Raffael"),
        :workshop => stub_model(Workshop, :owner => nil, :title => "Title", :description => "MyText", :starts => Time.now - 3.hours, :ends => Time.now - 2.hours)
      )
    ])
  end

  it "renders a list of attendances" do
    render

    assert_select "tr>td", :text => "Andreas".to_s, :count => 1
    assert_select "tr>td", :text => "Raffael".to_s, :count => 1
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
