require "fedex_rest_api/version"
require "httparty"
require "debug"

class FedexRestApi
  require "fedex_rest_api/auth"
  require "fedex_rest_api/track"
  require "fedex_rest_api/tracking_object"
  require "fedex_rest_api/address"
  require "fedex_rest_api/address_object"

  class ApiError < StandardError; end
end
