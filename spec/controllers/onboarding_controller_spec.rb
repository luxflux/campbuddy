require 'rails_helper'

describe OnboardingController do
  let(:user) { FactoryGirl.create(:user) }
  before do
    user.send_welcome_mail
  end

  describe 'GET start' do
    context 'existing token' do
      before do
        get :start, token: user.invitation_token
      end

      specify { expect(assigns(:user)).to eq(user) }
    end

    context 'nonexisting token' do
      it 'redirects to the root url' do
        get :start, token: 'invalid'
        expect(response).to redirect_to(root_url)
      end
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

    context 'valid password' do
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
        expect(response).to redirect_to root_url
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

    context 'invalid password' do
      let(:params) { { user: { token: user.invitation_token, password: '' } } }

      it 'does not set the password' do
        expect { post :finish, params }.to_not change { user.reload.encrypted_password }
      end

      it 'does not sign the user in' do
        expect { post :finish, params }.to_not change { controller.current_user }.from(nil)
      end

      it 'renders the template again' do
        post :finish, params
        expect(response).to render_template('start')
      end

      it 'does not remove the token' do
        expect { post :finish, params }.to_not change { user.reload.invitation_token }
      end
    end

    context 'nonexisting token' do
      it 'redirects to the root url' do
        params[:user][:token] = 'invalid'
        post :finish, params
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
