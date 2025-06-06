class ApplicationController < ActionController::Base
  include SessionsHelper
  # before_action :require_login

  def require_login
    return if current_user

    flash[:danger] = 'Googleログインが必要です'
    redirect_to root_path
  end
end