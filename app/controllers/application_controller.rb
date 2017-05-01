class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  http_basic_authenticate_with :name => ENV['BASIC_AUTH_USERNAME'], :password => ENV['BASIC_AUTH_PASSWORD'] if Rails.env == "production"
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

end
