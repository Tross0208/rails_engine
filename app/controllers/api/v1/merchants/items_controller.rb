class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    begin
      merchant = Merchant.find(params[:merchant_id])
      render json: ItemSerializer.new(Item.where(merchant_id: merchant.id)).serializable_hash.to_json
    rescue ActiveRecord::RecordNotFound
      render status: 404
    end
  end
end
