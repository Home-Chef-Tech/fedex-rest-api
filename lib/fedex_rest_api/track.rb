# frozen_string_literal: true

require "fedex_rest_api/base"

class FedexRestApi::Track
  attr_reader :tracking_object, :environment

  TRACK_URL = "/track/v1/trackingnumbers"

  def initialize(tracking_object, environment: FedexRestApi::Base::SANDBOX)
    @tracking_object = tracking_object
    @environment = environment
  end

  def track
    response = HTTParty.post(env_url,
      headers: {
        "Content-Type" => 'application/json',
        "Authorization" => "Bearer #{tracking_object.access_token}"
      },
      body: {
        "includeDetailedScans": tracking_object.include_detailed_scans,
        "trackingInfo": tracking_object.tracking_numbers
      }.to_json
    )

    raise FedexRestApi::ApiError if response['errors'] || response['error_description']
    response
  end

  def env_url
    if environment == FedexRestApi::Base::PRODUCTION_ENV
      "#{FedexRestApi::Base::PRODUCTION_URL}#{TRACK_URL}"
    else
      "#{FedexRestApi::Base::SANDBOX_URL}#{TRACK_URL}"
    end
  end
end
