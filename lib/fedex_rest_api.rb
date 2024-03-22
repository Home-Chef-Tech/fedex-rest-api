require "fedex_rest_api/version"
require "httparty"

class FedexRestApi
  require "fedex_rest_api/auth"

  class ApiError < StandardError; end
end
