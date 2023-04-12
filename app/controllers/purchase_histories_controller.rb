class PurchaseHistoriesController < ApplicationController
  before_action :item_params,  only: [:index, :create]
  # before_action :set_items,  only: [:index]
  
  def index
    # @items = Item.all.order(created_at: :desc)
    @purchase_shipping = PurchaseShipping.new
  end
  
  def new
  end


  def create
    @purchase_shipping = PurchaseShipping.new(purchase_history_params)
    if @purchase_shipping.valid? 
      @purchase_shipping.save
      redirect_to root_path
    else
      # set_items
      render :index
    end
  end


  private

  def item_params
    @item = Item.find(params[:item_id])
  end

  # def set_items
  #   @items = Item.all.order(created_at: :desc)
  #   @purchase_shipping = PurchaseShipping.new
  # end

  def donation_params
    params.permit(:price).merge(user_id: current_user.id)
  end

  def purchase_history_params
    params.permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id)
  end
  
end
