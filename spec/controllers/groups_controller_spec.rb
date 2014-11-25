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
  end
end
