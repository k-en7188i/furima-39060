class ItemsController < ApplicationController
  def index
    @items = Item.all
    @items = Item.order("created_at DESC")
  end

  def new
    @items = Item.new
  end

  # def create
  #   @item =Item.new(item_params)
  #   if @item.save
  #     redirect_to root_path
  #   else
  #     render :new
  #   end
  # end

  private

    def item_params
      params.require(:item).permit(:prefecture_id)
    end
end
