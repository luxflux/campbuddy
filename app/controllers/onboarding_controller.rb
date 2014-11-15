class OnboardingController < ApplicationController
  layout 'onboarding'
  skip_before_action :authorize

  def start
    @user = User.where(confirmation_token: params[:token]).first
  end

  def finish
    @user = User.where(confirmation_token: params[:user][:token]).first
    @user.password = params[:user][:password]
    @user.save!
    redirect_to events_path, notice: I18n.t('onboarding.password_set')
  end
end
