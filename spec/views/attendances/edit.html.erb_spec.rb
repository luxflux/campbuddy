require 'spec_helper'

describe "attendances/edit" do
  before(:each) do
    @attendance = assign(:attendance, stub_model(Attendance,
      :user => stub_model(User, email: "meil@domain.ch", name: "Andreas"),
      :workshop => stub_model(Workshop, :owner => nil, :title => "Title", :description => "MyText", :starts => Time.now - 3.hours, :ends => Time.now - 2.hours)
    ))
  end

  it "renders the edit attendance form" do
    render

    assert_select "form[action=?][method=?]", attendance_path(@attendance), "post" do
      assert_select "input#attendance_user_id[name=?]", "attendance[user_id]"
      assert_select "input#attendance_workshop_id[name=?]", "attendance[workshop_id]"
    end
  end
end
