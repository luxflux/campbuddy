require 'rails_helper'

RSpec.describe RootController, :type => :controller do
  before do
    sign_in_as user
  end

  describe 'GET show' do
    context 'as guest' do
      let(:user) { FactoryGirl.create(:user, admin: false, guest: true) }

      it 'redirects to the event catalog' do
        get :show
        expect(response).to redirect_to(catalog_events_path)
      end
    end

    context 'as normal user' do
      let(:user) { FactoryGirl.create(:user, admin: false) }

      it 'redirects to the news feed' do
        get :show
        expect(response).to redirect_to(news_index_path)
      end
    end
  end
end
