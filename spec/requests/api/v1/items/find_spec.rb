require 'rails_helper'

RSpec.describe 'The Item Find endpoint' do
  it 'returns JSON of a single matching item' do
    merchant1 = Merchant.create(name: "Jim")
    merchant2 = Merchant.create(name: "Tim")

    item1 = create :item, {name: "Can", merchant_id: merchant1.id}
    item2 = create :item, {name: "candle", merchant_id: merchant1.id}
    item3 = create :item, {name: "Anchor", merchant_id: merchant2.id}
    item4 = create :item, {name: "Digerydoo", merchant_id: merchant2.id}

    get "/api/v1/items/find?name=AN"

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
  end

  it 'returns empty JSON if no match found' do
    merchant1 = Merchant.create(name: "Jim")
    merchant2 = Merchant.create(name: "Tim")

    item1 = create :item, {name: "Can", merchant_id: merchant1.id}
    item2 = create :item, {name: "candle", merchant_id: merchant1.id}
    item3 = create :item, {name: "Anchor", merchant_id: merchant2.id}
    item4 = create :item, {name: "Digerydoo", merchant_id: merchant2.id}

    get "/api/v1/items/find?name=Oyster"

    expect(response).to be_successful
    full_response = JSON.parse(response.body, symbolize_names: true)

    expect(full_response).to have_key :data
    expect(full_response[:data]).to be_a Hash

    expect(full_response[:data].count).to eq(0)
  end
end
