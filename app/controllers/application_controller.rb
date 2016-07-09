class ApplicationController < ActionController::Base
  before_action :ensure_user_signed_in
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def ensure_user_signed_in
    @signed_in_user = User.find(1)
  end
end
