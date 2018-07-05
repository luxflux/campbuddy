require 'rails_helper'

describe NewsController do

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

    describe 'GET index' do
      it 'assigns all visible news as @news' do
        visible = FactoryBot.create :news, visible_until: Time.now + 10.hours
        invisible = FactoryBot.create :news, visible_until: Time.now + 1.hour

        Timecop.freeze Time.now + 2.hours

        get :index, {}

        expect(assigns(:news)).to eq([visible])
      end
    end
  end
end
