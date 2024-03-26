require "fedex_rest_api/version"
require "httparty"
require "debug"

class FedexRestApi
  require "fedex_rest_api/auth"

  class ApiError < StandardError; end
end
