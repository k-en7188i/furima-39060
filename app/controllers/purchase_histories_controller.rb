class PurchaseHistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :item_params,  only: [:index, :create, :new]
  before_action :set_items,  only: [:index, :create, :new]
  before_action :users_checking, only: [:index, :create, :new]  
  before_action :items_checking, only: [:index, :create, :new]  
  

  def index
    # @item = Item.all.order(created_at: :desc)
    @purchase_shipping = PurchaseShipping.new 
  end
  
  def new
    # @purchase_shipping = PurchaseShipping.new
  end


  def create
    @purchase_shipping = PurchaseShipping.new(purchase_history_params)
    if @purchase_shipping.valid? 
      @purchase_shipping.save
      
      redirect_to root_path
    else
      # binding.pry
      render :index
    end
  end


  private

  def item_params
    @item = Item.find(params[:item_id])
  end

  def set_items
    @items = Item.all.order(created_at: :desc)
    # @purchase_shipping = PurchaseShipping.new
  end

  def purchase_history_params
  # 理想系 # params.require(:purchase_shipping).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id)
    params.permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id)
  end
  
  def users_checking
    return unless current_user.id == @item.user_id
    redirect_to root_path
  end

  def items_checking
    return unless @item.purchase_history.presence
    redirect_to root_path 
  end

end
