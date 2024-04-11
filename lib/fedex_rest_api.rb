require "fedex_rest_api/version"
require "httparty"
require "debug"

class FedexRestApi
  require "fedex_rest_api/auth"
  require "fedex_rest_api/track"

  class ApiError < StandardError; end
end
