class Api::V1::ItemsController < ApplicationController
  def index
    if params[:merchant_id]
      begin
        merchant = Merchant.find(params[:merchant_id])
        items = Item.where(merchant_id: (params[:merchant_id]))
        render json: ItemSerializer.item_index(items)
      rescue ActiveRecord::RecordNotFound
        render status: 404
      end
    else
      items = Item.all
      render json: ItemSerializer.item_index(items)
    end
  end

  def show
    begin
      item = Item.find(params[:id])
      render json: ItemSerializer.item_show(item)
    rescue ActiveRecord::RecordNotFound
      render status: 404
    end
  end
end
