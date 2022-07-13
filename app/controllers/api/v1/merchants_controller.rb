class Api::V1::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    render json: MerchantSerializer.merchant_index(@merchants)
  end

  def show
    if @merchant = MerchantFacade.find_by_id(params[:id])
      render json: MerchantSerializer.merchant_show(@merchant)
    else
      render status: 404
    end
  end
end
