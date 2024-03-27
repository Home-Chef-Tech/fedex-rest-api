require "spec_helper"
require "fedex_rest_api/auth"
require "debug"

RSpec.describe FedexRestApi::Auth do
  let(:fedex) { FedexRestApi::Auth.new(fedex_credentials) }

  context "with valid credentials", :vcr do
    it "returns a successfull (200) response " do
      response = fedex.fetch_token

      expect(response.keys).to contain_exactly("access_token", "expires_in", "scope", "token_type")
      expect(response.code).to eq 200
    end
  end

  context "with invalid credentials", :vcr do
    it "raises an error" do
      expect{FedexRestApi::Auth.new({client_id: "fake"}).fetch_token}.to raise_error(FedexRestApi::ApiError)
    end
  end
end
