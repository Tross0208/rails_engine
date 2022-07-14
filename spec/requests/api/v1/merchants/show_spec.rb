require 'rails_helper'

RSpec.describe 'The Merchant Index endpoint' do
  it 'returns JSON of all merchants' do
    merchant1 = Merchant.create(name: "Jim")
    merchant2 = Merchant.create(name: "Tim")

    get "/api/v1/merchants/#{merchant1.id}"

    expect(response).to be_successful
    full_response = JSON.parse(response.body, symbolize_names: true)

    expect(full_response).to have_key :data
    expect(full_response[:data]).to be_a Hash

    expect(full_response[:data]).to have_key :id
    expect(full_response[:data][:id]).to be_a String

    expect(full_response[:data]).to have_key :attributes
    expect(full_response[:data][:attributes]).to be_a Hash

    expect(full_response[:data][:attributes]).to have_key :name
    expect(full_response[:data][:attributes][:name]).to eq ("Jim")
  end

  it 'returns 404 if no merchant found' do
    merchant1 = Merchant.create(name: "Jim")
    id = merchant1.id + 1

    get "/api/v1/merchants/#{id}"

    expect(response.status).to be 404
  end
end
