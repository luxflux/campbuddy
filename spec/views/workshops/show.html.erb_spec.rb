require 'spec_helper'

describe "workshops/show" do
  before(:each) do
    @workshop = assign(:workshop, stub_model(Workshop,
      :owner => nil,
      :title => "Title",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
  end
end
