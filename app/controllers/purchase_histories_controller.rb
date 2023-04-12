class PurchaseHistoriesController < ApplicationController
  before_action :item_params,  only: [:index, :create]
  
  def index
    # @item = Item.find(params[:item_id])
    @purchase_shipping = PurchaseShipping.new
  end
  
  def create
    # @item = Item.find(params[:item_id])
    @purchase_shipping = PurchaseShipping.new(purchase_history_params)
    if @purchase_shipping.valid?
      @purchase_shipping.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def item_params
    @item = Item.find(params[:item_id])
  end

  def purchase_history_params
    params.permit(:postal_code, :prefecture, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id)
  end
end
