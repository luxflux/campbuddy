class ApplicationController < ActionController::Base
  include Clearance::Controller
  helper IconsHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login
  before_action :set_locale

  rescue_from 'CanCan::AccessDenied' do |exception|
    redirect_to main_app.root_url
  end
  rescue_from 'ActiveRecord::RecordNotFound' do |exception|
    redirect_to main_app.root_url
  end

  def set_locale
    I18n.locale = :de
  end
end
