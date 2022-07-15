require 'rails_helper'

RSpec.describe 'The Item Show endpoint' do
  it 'returns JSON of one item by id ' do
    merchant1 = Merchant.create(name: "Jim")
    merchant2 = Merchant.create(name: "Tim")

    item1 = create :item, {merchant_id: merchant1.id}
    item4 = create :item, {merchant_id: merchant2.id}

    get "/api/v1/items/#{item1.id}"

    expect(response).to be_successful
    full_response = JSON.parse(response.body, symbolize_names: true)

    expect(full_response).to have_key :data
    expect(full_response[:data]).to be_a Hash

    expect(full_response[:data]).to have_key :id
    expect(full_response[:data][:id]).to be_a String

    expect(full_response[:data]).to have_key :attributes
    expect(full_response[:data][:attributes]).to be_a Hash

    expect(full_response[:data][:attributes]).to have_key :name
    expect(full_response[:data][:attributes][:name]).to eq (item1.name)
    expect(full_response[:data][:attributes][:name]).to_not eq (item4.name)

  end
end
