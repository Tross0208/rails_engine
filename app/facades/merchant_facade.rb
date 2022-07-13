class MerchantFacade
  def self.find_by_id(id)
    merchant = Merchant.find(id)
  end
end
