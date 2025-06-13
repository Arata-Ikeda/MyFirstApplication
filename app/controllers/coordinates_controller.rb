class CoordinatesController < ApplicationController
  before_action :require_login
  before_action :set_coordinate, only: [:show, :edit, :update, :destroy]

  def index
    @coordinates = current_user.coordinates.order(worn_on: :desc)
  end

  def new
    @coordinate = Coordinate.new
    @items = current_user.items.order(created_at: :desc)
  end

  def create
    @coordinate = Coordinate.new(coordinate_params)
    @coordinate.user = current_user
    if @coordinate.save
      redirect_to coordinates_path, notice: 'コーディネートが正常に作成されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @grouped_items = @coordinate.items.includes(:category, :brand).group_by(&:category)
  end

  def edit
    @items = current_user.items.order(created_at: :desc)
  end

  def update
    if @coordinate.update(coordinate_params)
      redirect_to @coordinate, notice: 'コーディネートを更新しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @coordinate = Coordinate.find(params[:id])
    @coordinate.destroy
    redirect_to coordinates_path, notice: 'コーディネートが削除されました。', status: :see_other
  end

  private

    def coordinate_params
      params.require(:coordinate).permit(:worn_on, :memo, :coordinate_image, item_ids: [])
    end

    def set_coordinate
      @coordinate = current_user.coordinates.find_by(id: params[:id])
      unless @coordinate
        redirect_to coordinates_path, alert: '他のユーザーのコーディネートは表示できません。'
        return
      end
    end
end
