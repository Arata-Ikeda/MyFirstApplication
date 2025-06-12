class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  def create
    user = User.find_by(google_id: auth_hash['uid'])
    if user
      log_in user
      redirect_to coordinates_path, notice: 'ログインしました'
    else
      # 新規Googleアカウントの場合は登録画面へ
      session[:google_auth] = {
        email: auth_hash['info']['email'],
        name: auth_hash['info']['name'],
        google_id: auth_hash['uid'],
        icon_url: auth_hash['info']['image']
      }
      redirect_to new_user_registration_path
    end
  end

  def destroy
    log_out
    session.delete(:profile_image_url)
    session.delete(:google_auth)
    redirect_to root_path, notice: 'ログアウトしました'
  end

  private
    def auth_hash
      request.env['omniauth.auth']
    end
end