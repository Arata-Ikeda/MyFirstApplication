class WishesController < ApplicationController
  def index
    @wish_items = current_user.items.status_wish.includes(:brand, :season, :category).order(created_at: :desc)
  end

  def new
    @wish_item = Item.new
    @wish_item.build_brand
    @wish_item.build_season
  end

  # itemコントローラーのCreateアクションを流用
  def create
    @wish_item = Item.new(item_params.except(:brand_attributes, :season_attributes))
    @wish_item.user = current_user
    @wish_item.status = :wish

    if brand_name = params.dig(:item, :brand_attributes, :name).presence
      @wish_item.brand = Brand.find_or_create_by(name: brand_name)
    end

    if season_name = params.dig(:item, :season_attributes, :name).presence
      @wish_item.season = Season.find_or_create_by(name: season_name)
    end

    if @wish_item.save
      redirect_to wishes_path, notice: 'My Wish Listに追加されました。'
    else
      @wish_item.build_brand unless @wish_item.brand
      @wish_item.build_season unless @wish_item.season
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    @wish_item = current_user.items.status_wish.find(params[:id])
    @wish_item.destroy
    redirect_to wishes_path, notice: 'My Wish Listからアイテムを削除しました。', status: :see_other
  end

  def show
    @wish_item = current_user.items.status_wish.includes(:category, :brand, :season).find(params[:id])
  end

  def edit
    @wish_item = current_user.items.status_wish.includes(:category, :brand, :season).find(params[:id])
    @wish_item.build_brand unless @wish_item.brand
    @wish_item.build_season unless @wish_item.season
  end

  def update
    @wish_item = current_user.items.status_wish.includes(:category, :brand, :season).find(params[:id])
    if brand_name = params.dig(:item, :brand_attributes, :name).presence
      @wish_item.brand = Brand.find_or_create_by(name: brand_name)
    end

    if season_name = params.dig(:item, :season_attributes, :name).presence
      @wish_item.season = Season.find_or_create_by(name: season_name)
    end

    if @wish_item.update(item_params)
      redirect_to wish_path(@wish_item), notice: '欲しいものリストのアイテムを更新しました。'
    else
      @wish_item.build_brand unless @wish_item.brand
      @wish_item.build_season unless @wish_item.season
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def item_params
    params.require(:item).permit(
      :name,
      :memo,
      :category_id,
      :item_image, # ActiveStorage用の画像フィールド
      :price,
      brand_attributes: [:id, :name],
      season_attributes: [:id, :name]
    )
  end
end
