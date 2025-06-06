class RegistrationsController < ApplicationController
  def new
    @user = User.new(session[:google_auth] || {})
  end

  def create
    if User.exists?(email: user_params[:email])
      flash.now[:alert] = 'このメールアドレスは既に登録されています。ログインしてください。'
      @user = User.new(user_params)
      render :new, status: :unprocessable_entity
      return
    end
    @user = User.new(user_params)
    if params[:user][:icon]
      @user.icon.attach(params[:user][:icon])
    end
    if @user.save
      log_in @user
      session.delete(:google_auth)
      redirect_to root_path, notice: 'ユーザー登録が完了しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :google_id)
  end
end
