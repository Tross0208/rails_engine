class Api::V1::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    render json: MerchantSerializer.merchant_index(@merchants)
  end

  def show
    begin
      merchant = Merchant.find(params[:id])
      render json: MerchantSerializer.merchant_show(merchant)
    rescue ActiveRecord::RecordNotFound
      render status: 404
    end
  end
end
