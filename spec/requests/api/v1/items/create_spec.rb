require 'rails_helper'

RSpec.describe 'The Items Create endpoint' do
  it 'creates new Item' do
    merchant = Merchant.create(name: "Sodie Monger")
    item_params = ({
                  name: 'Empty can of Pepsi MAX',
                  description: 'Can of Pepsi Max, opened, contents gaseous ONLY',
                  unit_price: 17,
                  merchant_id: merchant.id,
                })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item_params)
    created_item = Item.last

    expect(response.status).to be 201
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end
  it 'Doesnt create number with string for price' do
    merchant = Merchant.create(name: "Sodie Monger")
    item_params = ({
                  name: 'Empty can of Pepsi MAX',
                  description: 'Can of Pepsi Max, opened, contents gaseous ONLY',
                  unit_price: "I SHOULD BE A NUMBER",
                  merchant_id: merchant.id,
                })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item_params)
    created_item = Item.last

    expect(response.status).to be 404
  end
end
