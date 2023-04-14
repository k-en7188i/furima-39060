# class ShippingAddressesController < ApplicationController
#   def index
#   end

#   def create
#     Shipping_address.create(shipping_address_params)
#   end

#   private
#   def shipping_address_params
#     params.require(:comment).permit(:text).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
#   end
# end
