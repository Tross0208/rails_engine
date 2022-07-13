class Api::V1::MerchantsController::MerchantSerializer
  def self.merchant_index(merchants)
    {
      data: merchants.map do |merchant|
        {
          type: "merchant",
          id: merchant.id.to_s,
          attributes: {
            name: merchant.name
          }
        }
      end
    }
  end

  def self.merchant_show(merchant)
    {
      data:
        {
          type: "merchant",
          id: merchant.id.to_s,
          attributes: {
            name: merchant.name
          }
        }
    }
  end
end
