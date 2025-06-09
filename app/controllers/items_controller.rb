# app/controllers/items_controller.rb
class ItemsController < ApplicationController
  def index
    @items = Item.all.includes(:category, :brand, :season).order(created_at: :desc)
  end

  def new
    @item = Item.new
    @item.build_brand # これも忘れずに！newアクションでフォームが正しく初期化されるように
    @item.build_season # これも忘れずに！
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user 

    if brand_name = params[:item][:brand_attributes][:name].presence
      @item.brand = Brand.find_or_create_by(name: brand_name)
    end

    if season_name = params[:item][:season_attributes][:name].presence
      @item.season = Season.find_or_create_by(name: season_name)
    end

    if @item.save
        redirect_to items_path, notice: "アイテムが正常に作成されました。"
    else
        render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.includes(:category, :brand, :season).find(params[:id])
  end

  def edit
    @item = Item.includes(:category, :brand, :season).find(params[:id])
    @item.build_brand unless @item.brand # brandが存在しない場合は新規作成用のフォームを表示
    @item.build_season unless @item.season # seasonが存在しない場合は新規作成用のフォームを表示
  end

  def update
    @item = Item.includes(:category, :brand, :season).find(params[:id])
    
    if brand_name = params[:item][:brand_attributes][:name].presence
      @item.brand = Brand.find_or_create_by(name: brand_name)
    end

    if season_name = params[:item][:season_attributes][:name].presence
      @item.season = Season.find_or_create_by(name: season_name)
    end

    if @item.update(item_params)
      redirect_to item_path(@item), notice: "アイテムが正常に更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy # データベースからアイテムを削除する
    redirect_to items_path, notice: 'アイテムが正常に削除されました。'
  end

  private

  def item_params
    params.require(:item).permit(
      :name,
      :memo,
      :category_id,
      :item_image,
      :purchase_date,
      :price,
      brand_attributes: [:name],
      season_attributes: [:name]
    )
  end
end