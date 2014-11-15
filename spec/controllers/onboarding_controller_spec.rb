require 'rails_helper'

describe OnboardingController do
  let(:user) { FactoryGirl.create(:user) }
  before do
    user.generate_invitation_token
    user.save!
  end

  describe 'GET start' do
    before do
      get :start, token: user.confirmation_token
    end

    specify { expect(assigns(:user)).to eq(user) }
  end

  describe 'POST finish' do
    let(:params) do
      { user: { token: user.confirmation_token, password: 'new-password' } }
    end

    it 'loads the user according to its token' do
      post :finish, params
      expect(assigns(:user)).to eq(user)
    end

    it 'sets the password' do
      expect {
        post :finish, params
      }.to change { user.reload.encrypted_password }
    end

    it 'signs the user in' do
      expect {
        post :finish, params
      }.to change { controller.current_user }.from(nil).to(user)
    end

    it 'redirects to the events' do
      post :finish, params
      expect(response).to redirect_to events_path
    end
  end
end
