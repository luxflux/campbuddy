require 'spec_helper'

describe "workshops/edit" do
  before(:each) do
    @workshop = assign(:workshop, stub_model(Workshop,
      :owner => nil,
      :title => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit workshop form" do
    render

    assert_select "form[action=?][method=?]", workshop_path(@workshop), "post" do
      assert_select "input#workshop_owner[name=?]", "workshop[owner]"
      assert_select "input#workshop_title[name=?]", "workshop[title]"
      assert_select "textarea#workshop_description[name=?]", "workshop[description]"
    end
  end
end
