require "fedex_rest_api/base"
require "debug"

class FedexRestApi::Track
  attr_reader :tracking_object

  def initialize(tracking_object)
    @tracking_object = tracking_object
  end

  def track
    response = HTTParty.post("#{env_url}",
      headers: {
        "Content-Type" => 'application/json',
        "Authorization" => "Bearer #{tracking_object[:auth_token]}"
      },
      body: {
        "trackingInfo": [
          {
            "trackingNumberInfo": {
              "trackingNumber": tracking_object[:tracking_number]
            }
          }
        ],
        "includeDetailedScans": true
      }
    )

    raise FedexRestApi::ApiError if response['errors']
    response
  end

  def env_url
    if tracking_object[:environment] && tracking_object[:environment] == FedexRestApi::Base::PRODUCTION_ENV
      FedexRestApi::Base::PRODUCTION_TRACK_URL
    else
      FedexRestApi::Base::SANDBOX_TRACK_URL
    end
  end
end
