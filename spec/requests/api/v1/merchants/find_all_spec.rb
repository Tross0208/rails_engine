require 'rails_helper'

RSpec.describe 'The Merchant Find All endpoint' do
  it 'returns JSON of all merchants' do
    merchant1 = Merchant.create(name: "JIM")
    merchant2 = Merchant.create(name: "Tim")
    merchant2 = Merchant.create(name: "John")

    get '/api/v1/merchants/find_all?name=IM'

    expect(response).to be_successful
    full_response = JSON.parse(response.body, symbolize_names: true)

    expect(full_response).to have_key :data
    expect(full_response[:data]).to be_an Array
    expect(full_response[:data].count).to eq(2)

    expect(full_response[:data].first).to have_key :id
    expect(full_response[:data].first[:id]).to eq(merchant1.id.to_s)

    expect(full_response[:data].first).to have_key :attributes
    expect(full_response[:data].first[:attributes]).to be_a Hash

    expect(full_response[:data].first[:attributes]).to have_key :name
    expect(full_response[:data].first[:attributes][:name]).to eq ("JIM")

  end
end
