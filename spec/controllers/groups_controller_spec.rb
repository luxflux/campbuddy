require 'rails_helper'

describe GroupsController do

  context 'a guest' do
    before do
      get :index
    end

    it { should deny_access }
  end

  context 'a user' do
    let(:user) { FactoryBot.create :user }

    before do
      sign_in_as user
    end

    describe "GET index" do
      it "assigns the current users groups to @groups" do
        group = FactoryBot.create :group
        other_group = FactoryBot.create :group
        user.groups << group
        get :index, {}
        expect(assigns(:groups)).to eq([group])
      end
    end
  end
end
