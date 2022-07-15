class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, numericality: true

  belongs_to :merchant

  def self.item_search(name)
    item = Item.where("name ILIKE '%#{name}%'")
    return item.first
  end
end
