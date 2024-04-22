require "spec_helper"
require "fedex_rest_api/auth"
require "fedex_rest_api/track"

RSpec.describe FedexRestApi::Track do
  let(:auth) { FedexRestApi::Auth.new(fedex_tracking_credentials).fetch_token }
  let(:fedex) { FedexRestApi::Track.new(tracking_object) }
  let(:tracking_object) { FedexRestApi::TrackingObject.new({access_token: auth["access_token"], include_detailed_scans: true, trackable_numbers: [794843185271, 449044304137821]}) }

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
      tracking_object = FedexRestApi::TrackingObject.new({access_token: "123"})
      expect{FedexRestApi::Track.new(tracking_object).track}.to raise_error(FedexRestApi::ApiError)
    end
  end
end
