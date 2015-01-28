require 'rails_helper'

RSpec.describe EmergencyNumbersController, type: :controller do
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
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end
end
