class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items

  def self.merchant_search(name)
    Merchant.where("name ILIKE '%#{name}%'")
  end

end
