class Api::V1::ItemsController::ItemSerializer
  def self.item_index(items)
    {
      data: items.map do |item|
        {
          type: "item",
          id: item.id.to_s,
          attributes: {
            name: item.name,
            description: item.description,
            unit_price: item.unit_price,
            merchant_id: item.merchant_id
          }
        }
      end
    }
  end
end
