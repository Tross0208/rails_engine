class Api::V1::MerchantController < ApplicationController
  def index
    begin
      item = Item.find(params[:item_id])
      merchant = Merchant.find(item.merchant_id)
      render json: MerchantSerializer.merchant_show(merchant)
    rescue ActiveRecord::RecordNotFound
      render status: 404
    end
  end
end
