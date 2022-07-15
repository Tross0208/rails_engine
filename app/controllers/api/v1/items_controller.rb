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

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.item_show(item), status: 201
    else
      render status: 404
    end
  end

  def delete
    begin
      item = Item.find(params[:id])
      item.destroy
    rescue ActiveRecord::RecordNotFound
      render status: 404
    end
  end

  private

  def item_params
    params.permit(:id, :name, :unit_price, :description, :merchant_id)
  end

end
