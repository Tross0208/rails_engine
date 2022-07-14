class Api::V1::ItemsController::ItemSerializer
  def self.item_index(items, merchant)
    {
      data: items.map do |item|
        {
          type: "item",
          id: item.id.to_s,
          attributes: {
            name: item.name,
            description: item.description,
            unit_price: item.unit_price,
            merchant_id: merchant.id
          }
        }
      end
    }
  end
end
