# app/controllers/items_controller.rb
class ItemsController < ApplicationController
  def index
  # ベースとなるクエリを準備（ログインユーザーの、所持品だけ）
  items_relation = current_user.items.status_owned.includes(:brand, :season, :category).order(created_at: :desc)

  if params[:category_id].present?
    items_relation = items_relation.where(category_id: params[:category_id])
  end

  @items = items_relation.includes(:category, :brand, :season).order(created_at: :desc)
end

  def new
    @item = Item.new
    @item.build_brand 
    @item.build_season 
  end

  def create
  # item_paramsから、ネストした属性を除外してインスタンスを初期化
    @item = Item.new(item_params.except(:brand_attributes, :season_attributes))
    @item.user = current_user
    @item.status = :owned 

    # digを使って安全にブランド名を取得
    if brand_name = params.dig(:item, :brand_attributes, :name).presence
      @item.brand = Brand.find_or_create_by(name: brand_name)
    end

    # digを使って安全にシーズン名を取得
    if season_name = params.dig(:item, :season_attributes, :name).presence
      @item.season = Season.find_or_create_by(name: season_name)
    end

    if @item.save
      redirect_to items_path, notice: 'アイテムが正常に作成されました。'
    else
      @item.build_brand unless @item.brand
      @item.build_season unless @item.season
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = current_user.items.status_owned.includes(:category, :brand, :season).find(params[:id])
  end

  def edit
    @item = current_user.items.status_owned.includes(:category, :brand, :season).find(params[:id])
    @item.build_brand unless @item.brand # brandが存在しない場合は新規作成用のフォームを表示
    @item.build_season unless @item.season # seasonが存在しない場合は新規作成用のフォームを表示
  end

  def update
    @item = current_user.items.status_owned.includes(:category, :brand, :season).find(params[:id])
    
    if brand_name = params.dig(:item, :brand_attributes, :name).presence
      @item.brand = Brand.find_or_create_by(name: brand_name)
    end

    if season_name = params.dig(:item, :season_attributes, :name).presence
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