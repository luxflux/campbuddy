class ApplicationController < ActionController::Base
  include Clearance::Controller
  helper IconsHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_camp
  before_action :require_login
  before_action :set_locale
  before_action :mailer_set_url_options

  rescue_from 'CanCan::AccessDenied' do |exception|
    redirect_to main_app.root_url
  end
  rescue_from 'ActiveRecord::RecordNotFound' do |exception|
    redirect_to main_app.root_url
  end

  def set_locale
    I18n.locale = :de
  end

  def set_camp
    @camp = Camp.current
  rescue ActiveRecord::RecordNotFound
    raise "Cannot find camp for #{Apartment::Tenant.current}"
  end

  def current_ability
    @current_ability ||= ::Ability.new(current_user, @camp)
  end

  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
end
