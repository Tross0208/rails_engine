class Api::V1::ItemsController < ApplicationController
  def index
    if params[:merchant_id]
      begin
        merchant = Merchant.find(params[:merchant_id])
        items = Item.where(merchant_id: (params[:merchant_id]))
        render json: ItemSerializer.item_index(items, merchant)
      rescue ActiveRecord::RecordNotFound
        render status: 404
      end
    end
  end
end
