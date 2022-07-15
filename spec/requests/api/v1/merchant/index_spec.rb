require 'rails_helper'

RSpec.describe 'The Item Index endpoint' do
  it 'returns JSON of an items merchant' do
    merchant1 = Merchant.create(name: "Jim")
    merchant2 = Merchant.create(name: "Tim")

    item1 = create :item, {merchant_id: merchant1.id}
    item2 = create :item, {merchant_id: merchant2.id}

    get "/api/v1/items/#{item1.id}/merchant"

    expect(response).to be_successful
    full_response = JSON.parse(response.body, symbolize_names: true)

    expect(full_response).to have_key :data
    expect(full_response[:data]).to be_a Hash

    expect(full_response[:data]).to have_key :id
    expect(full_response[:data][:id]).to eq(merchant1.id.to_s)

    expect(full_response[:data]).to have_key :attributes
    expect(full_response[:data][:attributes]).to be_a Hash

    expect(full_response[:data][:attributes]).to have_key :name
    expect(full_response[:data][:attributes][:name]).to eq (merchant1.name)

  end

  it 'Returns 404 when item not found' do
    merchant1 = Merchant.create(name: "Jim")
    merchant2 = Merchant.create(name: "Tim")

    item1 = create :item, {merchant_id: merchant1.id}
    item2 = create :item, {merchant_id: merchant2.id}

    get "/api/v1/items/#{item2.id + 1}/merchant"

    expect(response.status).to be 404
  end
end
