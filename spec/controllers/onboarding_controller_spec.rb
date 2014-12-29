require 'rails_helper'

describe OnboardingController do
  let(:user) { FactoryGirl.create(:user) }
  before do
    user.generate_invitation_token
    user.save!
  end

  describe 'GET start' do
    context 'existing token' do
      before do
        get :start, token: user.invitation_token
      end

      specify { expect(assigns(:user)).to eq(user) }
    end

    context 'nonexisting token' do
      specify { expect { get :start, token: 'invalid' }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end

  describe 'POST finish' do
    let(:params) do
      { user: { token: user.invitation_token, password: 'new-password' } }
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

    it 'removes the token' do
      expect {
        post :finish, params
      }.to change { user.reload.invitation_token }.to(nil)
    end

    it 'sets a flash message' do
      post :finish, params
      expect(flash[:success]).to_not be_blank
    end
  end
end
