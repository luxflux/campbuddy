class OnboardingController < ApplicationController
  layout 'onboarding'
  skip_before_action :require_login

  def start
    @user = User.where(invitation_token: params[:token]).first!
  end

  def finish
    @user = User.where(invitation_token: params[:user][:token]).first
    @user.update_password params[:user][:password]
    if @user.valid?
      @user.invitation_token = nil
      @user.save
      sign_in @user
      flash[:success] = I18n.t('onboarding.password_set')
      redirect_to root_path
    else
      render :start
    end
  end
end
