class UsersController < ApplicationController
  before_action :require_login
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @item_count = @user.items.status_owned.count
    @coordinate_count = @user.coordinates.count
    @wish_count = @user.items.status_wish.count
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'プロフィールを更新しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :icon)
  end
end