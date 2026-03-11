require "spec_helper"
require "fedex_rest_api/auth"
require "fedex_rest_api/address"

RSpec.describe FedexRestApi::Address do
  let(:auth) { FedexRestApi::Auth.new(fedex_address_credentials).fetch_token }
  let(:address_object) { FedexRestApi::AddressObject.new({access_token: auth["access_token"], addresses: [sample_address]}) }
  let(:fedex) { FedexRestApi::Address.new(address_object) }

  context "with a valid access token", :vcr do
    describe "when a request is submitted with one or more valid addresses" do
      it "returns a valid response" do
        response = fedex.validate

        expect(response.code).to eq 200
      end
    end
  end

  context "with an invalid or expired access token", :vcr do
    let(:address_object) { FedexRestApi::AddressObject.new({access_token: "invalid"}) }

    it "raises an error" do
      expect{FedexRestApi::Address.new(address_object).validate}.to raise_error(FedexRestApi::ApiError)
    end
  end
end

def sample_address
  {
    "address": {
      "street": ["7372 PARKRIDGE BLVD", "APT 286"],
      "city": "IRVING",
      "stateOrProvinceCode": "TX",
      "postalCode": "75063-8659",
      "country": "US"
    }
  }
end
