class Api::V1::MerchantController::MerchantSerializer

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
