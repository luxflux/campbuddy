require 'spec_helper'

describe "workshops/new" do
  before(:each) do
    assign(:workshop, stub_model(Workshop,
      :owner => nil,
      :title => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new workshop form" do
    render

    assert_select "form[action=?][method=?]", workshops_path, "post" do
      assert_select "input#workshop_owner[name=?]", "workshop[owner]"
      assert_select "input#workshop_title[name=?]", "workshop[title]"
      assert_select "textarea#workshop_description[name=?]", "workshop[description]"
    end
  end
end
