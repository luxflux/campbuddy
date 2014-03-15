require 'spec_helper'

describe "attendances/new" do
  before(:each) do
    assign(:attendance, stub_model(Attendance,
      :user => stub_model(User, email: "meil@domain.ch", name: "Andreas"),
      :workshop => stub_model(Workshop, :owner => nil, :title => "Title", :description => "MyText", :starts => Time.now - 3.hours, :ends => Time.now - 2.hours)
    ).as_new_record)
  end

  it "renders new attendance form" do
    render

    assert_select "form[action=?][method=?]", attendances_path, "post" do
      assert_select "input#attendance_user_id[name=?]", "attendance[user_id]"
      assert_select "input#attendance_workshop_id[name=?]", "attendance[workshop_id]"
    end
  end
end
