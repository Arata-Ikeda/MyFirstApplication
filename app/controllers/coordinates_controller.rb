class CoordinatesController < ApplicationController

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
    @coordinate = Coordinate.find(params[:id])
    @grouped_items = @coordinate.items.includes(:category, :brand).group_by(&:category)
  end

  def edit
    @coordinate = Coordinate.find(params[:id])
    @items = current_user.items.order(created_at: :desc)
  end

  def update
    @coordinate = Coordinate.find(params[:id])
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
end
