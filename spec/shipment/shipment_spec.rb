require "spec_helper"
require "fedex_rest_api/auth"
require "fedex_rest_api/shipment"

RSpec.describe FedexRestApi::Shipment do
  let(:valid_shipment_object_params) {
    {
      access_token: auth["access_token"], 
      account_number: "510087720", 
      shipper: {
        address: { 
          street_lines: ["10 FedEx Parkway", "Suite 302"], 
          city: "Beverly Hills", 
          state_or_province_code: "CA", 
          postal_code: "90210", 
          country_code: "US" 
        },
        contact: { company_name: "Home Chef", phone_number: "1234567890" }
      }, 
      recipients: [{
        address: { 
          street_lines: ["7372 PARKRIDGE BLVD", "APT 286"], 
          city: "Irving", 
          state_or_province_code: "TX", 
          postal_code: "75063", 
          country_code: "US" 
        },
        contact: { person_name: "Jane Doe", phone_number: "0987654321" }
      }], 
      shipping_charges_payment: { payment_type: "SENDER" },
      ship_datestamp: Time.now.strftime("%Y-%m-%d")
    }
  }
  let(:auth) { FedexRestApi::Auth.new(fedex_shipment_credentials).fetch_token }
  let(:shipment_object) { FedexRestApi::ShipmentObject.new(valid_shipment_object_params) }
  let(:subject) { described_class.new(FedexRestApi::ShipmentObject.new(valid_shipment_object_params)) }

  context "with a valid access token", :vcr do
    describe "when a request is submitted with valid shipment data" do
      it "returns a valid response" do
        response = subject.label

        expect(response.code).to eq 200
      end
    end
  end

  context "with an invalid or expired access token", :vcr do
    it "raises an error" do
      valid_shipment_object_params[:access_token] = "bad token"
      expect { subject.label }.to raise_error(FedexRestApi::ApiError)
    end
  end
end
