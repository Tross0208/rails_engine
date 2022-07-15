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

  def self.item_show(item)
    {
      data:
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
      }
  end

  def self.item_search(item)
    {
      data:
        {
          id: item.id.to_s,
          type: "item",
          attributes: {
            name: item.name,
            description: item.description,
            unit_price: item.unit_price,
            merchant_id: item.merchant_id            
          }
        }
      }
  end

  def self.blank
    {
      data: {
        }
    }
  end
end
