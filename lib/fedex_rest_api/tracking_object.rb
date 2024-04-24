require "fedex_rest_api/base"

class FedexRestApi::TrackingObject
  attr_reader :access_token, :include_detailed_scans, :trackable_numbers

  def initialize(tracking_params)
    @access_token = tracking_params[:access_token]
    @include_detailed_scans = tracking_params[:include_detailed_scans] || false
    @trackable_numbers = tracking_params[:trackable_numbers] || []
  end

  def tracking_numbers
    trackable_numbers.map do |tracking_number|
      tracking_objects << {
        "trackingNumberInfo": {
          "trackingNumber": tracking_number
        }
      }
    end
  end
end
