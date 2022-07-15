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

  def update
    begin
      if params[:merchant_id]
        merchant = Merchant.find(params[:merchant_id])
      end
      item = Item.find(params[:id])
      item.update(item_params)
      render json: ItemSerializer.item_show(item), status: 201
    rescue ActiveRecord::RecordNotFound
      render status: 404
    end
  end

  def find
    if ((params[:name] && params[:min_price]) || (params[:name] && params[:max_price]))
      render status: 400
    else
      if params[:name]
        item = Item.item_search_by_name(params[:name])
        if item
          render json: ItemSerializer.item_show(item)
        else
          render json: ItemSerializer.blank
        end
      end
      if params[:min_price] #&& params[:min_price].to_i > 0
        item = Item.item_search_by_min_price(params[:min_price])
        if item
          render json: ItemSerializer.item_search(item)
        else
          render json: ItemSerializer.blank
        end
      #else
      # render json: ItemSerializer.blank, status: 400
      end
      if params[:max_price]
        item = Item.item_search_by_max_price(params[:max_price])
        if item
          render json: ItemSerializer.item_search(item)
        else
          render json: ItemSerializer.blank
        end
      end
    end
  end

  private

  def item_params
    params.permit(:id, :name, :unit_price, :description, :merchant_id)
  end

end
