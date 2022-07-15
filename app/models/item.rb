class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, numericality: true

  belongs_to :merchant

  def self.item_search_by_name(name)
    item = Item.where("name ILIKE '%#{name}%'")
    return item.first
  end

  def self.item_search_by_min_price(price)
    item = Item.where("unit_price >='#{price.to_f}'")
    return item.first
  end

  def self.item_search_by_max_price(price)
    item = Item.where("unit_price <='#{price.to_f}'")
    return item.first
  end
end
