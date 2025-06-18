class BrandsController < ApplicationController
  before_action :require_login
  before_action :set_user
  before_action :set_brand, only: [:update, :destroy]

  def create
    @brand = @user.brands.build(brand_params)
    
    if @brand.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "brands-list",
            partial: "users/brands_list",
            locals: { user: @user }
          )
        end
        format.html { redirect_to user_path(@user), notice: "ブランドを追加しました。" }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "brands-list",
            partial: "users/brands_list",
            locals: { user: @user, error: @brand.errors.full_messages.first }
          )
        end
        format.html { redirect_to user_path(@user), alert: @brand.errors.full_messages.first }
      end
    end
  end

  def update
    if @brand.update(brand_params)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "brands-list",
            partial: "users/brands_list",
            locals: { user: @user }
          )
        end
        format.html { redirect_to user_path(@user), notice: "ブランド名を更新しました。" }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "brands-list",
            partial: "users/brands_list",
            locals: { user: @user, error: @brand.errors.full_messages.first }
          )
        end
        format.html { redirect_to user_path(@user), alert: @brand.errors.full_messages.first }
      end
    end
  end

  def destroy
    if @brand.items.exists?
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "brands-list",
            partial: "users/brands_list",
            locals: { user: @user, error: "このブランドは使用中のため削除できません。" }
          )
        end
        format.html { redirect_to user_path(@user), alert: "このブランドは使用中のため削除できません。" }
      end
    else
      @brand.destroy
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "brands-list",
            partial: "users/brands_list",
            locals: { user: @user }
          )
        end
        format.html { redirect_to user_path(@user), notice: "ブランドを削除しました。" }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
    unless @user == current_user
      redirect_to user_path(current_user), alert: "他のユーザーのブランドは編集できません。"
    end
  end

  def set_brand
    @brand = @user.brands.find(params[:id])
  end

  def brand_params
    params.permit(:name)
  end
end