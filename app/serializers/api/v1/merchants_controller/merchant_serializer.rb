class Api::V1::MerchantsController::MerchantSerializer
  def self.merchant_index(merchants)
    {
      data: merchants.map do |merchant|
        {
          id: merchant.id.to_s,
          attributes: {
            name: merchant.name
          }
        }
      end
    }
  end
end
