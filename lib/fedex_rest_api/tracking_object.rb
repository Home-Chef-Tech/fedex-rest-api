require "fedex_rest_api/base"
require "debug"

class FedexRestApi::TrackingObject
  attr_reader :tracking_params

  def initialize(tracking_params)
    @tracking_params = tracking_params
    binding.break
  end

  def access_token
    tracking_object[:access_token]
  end

  def include_detailed_scans
    tracking_object[:include_detailed_scans]
  end

  def tracking_numbers
    tracking_object[:tracking_numbers]
  end
end
