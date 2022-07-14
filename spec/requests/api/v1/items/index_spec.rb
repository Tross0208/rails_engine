require 'rails_helper'

RSpec.describe 'The Item Index endpoint' do
  it 'returns JSON of all items by a merchant' do
    merchant1 = Merchant.create(name: "Jim")
    merchant2 = Merchant.create(name: "Tim")

    item1 = create :item, {merchant_id: merchant1.id}
    item2 = create :item, {merchant_id: merchant1.id}
    item3 = create :item, {merchant_id: merchant2.id}
    item4 = create :item, {merchant_id: merchant2.id}

    get "/api/v1/merchants/#{merchant1.id}/items"

    expect(response).to be_successful
    full_response = JSON.parse(response.body, symbolize_names: true)

    expect(full_response).to have_key :data
    expect(full_response[:data]).to be_an Array
    expect(full_response[:data].count).to eq(2)

    expect(full_response[:data].first).to have_key :id
    expect(full_response[:data].first[:id]).to be_a String

    expect(full_response[:data].first).to have_key :attributes
    expect(full_response[:data].first[:attributes]).to be_a Hash

    expect(full_response[:data].first[:attributes]).to have_key :name
    expect(full_response[:data].first[:attributes][:name]).to eq (item1.name)

  end

  it 'Returns 404 when merchant not found' do
    merchant1 = Merchant.create(name: "Jim")
    merchant2 = Merchant.create(name: "Tim")

    item1 = create :item, {merchant_id: merchant1.id}
    item2 = create :item, {merchant_id: merchant1.id}
    item3 = create :item, {merchant_id: merchant2.id}
    item4 = create :item, {merchant_id: merchant2.id}

    get "/api/v1/merchants/60678/items"

    expect(response.status).to be 404
  end
end
