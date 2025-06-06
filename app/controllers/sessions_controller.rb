class SessionsController < ApplicationController
  def create
    user = find_or_create_from_auth_hash(auth_hash)
    if user
      log_in user
      session[:profile_image_url] = auth_hash['info']['image']
    end
    redirect_to root_path
  end

  def destroy
    log_out
    session.delete(:profile_image_url)
    redirect_to root_path
  end

  private

    def auth_hash
      request.env['omniauth.auth']
    end

    def find_or_create_from_auth_hash(auth_hash)
      email = auth_hash['info']['email']
      User.find_or_create_by(email: email) do |user|
        user.update(email: email)
      end
    end
end