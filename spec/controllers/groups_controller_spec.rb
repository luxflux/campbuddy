require 'rails_helper'

describe GroupsController do

  context 'a guest' do
    before do
      get :index
    end

    it { should deny_access }
  end

  context 'a user' do
    before do
      sign_in
    end

    describe "GET index" do
      it "assigns all groups as @groups" do
        group = FactoryGirl.create :group
        get :index, {}
        expect(assigns(:groups)).to eq([group])
      end
    end

    describe "GET show" do
      it "assigns the requested group as @group" do
        group = FactoryGirl.create :group
        get :show, {:id => group.to_param}
        expect(assigns(:group)).to eq(group)
      end
    end
  end
end
