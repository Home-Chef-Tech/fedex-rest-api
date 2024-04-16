require "spec_helper"
require "fedex_rest_api/auth"
require "fedex_rest_api/track"

RSpec.describe FedexRestApi::Track do
  let(:auth) { FedexRestApi::Auth.new(fedex_tracking_credentials).fetch_token }
  let(:fedex) { FedexRestApi::Track.new({access_token: auth["access_token"], include_detailed_scans: true, tracking_numbers: tracking_numbers}) }

  context "with a valid access token", :vcr do
    describe "when a request is submitted with one or more valid tracking numbers" do
      it "returns a valid response" do
        response = fedex.track

        expect(response.code).to eq 200
      end
    end
  end

  context "with an invalid or expired access token", :vcr do
    it "raises an error" do
      expect{FedexRestApi::Track.new({access_token: "123"}).track}.to raise_error(FedexRestApi::ApiError)
    end
  end
end

def tracking_numbers
  [
    {
      "trackingNumberInfo": {
        "trackingNumber": 794843185271
      }
    },
    {
      "trackingNumberInfo": {
        "trackingNumber": 449044304137821
      }
    }
  ]
end
