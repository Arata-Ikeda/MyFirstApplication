class ApplicationController < ActionController::Base
  include SessionsHelper
  # before_action :require_login

  def require_login
    unless current_user
      redirect_to login_path, alert: 'ログインが必要です。'
    end
  end
end