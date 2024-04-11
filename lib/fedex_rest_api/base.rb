class FedexRestApi::Base
  PRODUCTION_ENV = "production".freeze

  # Access Token URLs
  SANDBOX_OAUTH_URL = "https://apis-sandbox.fedex.com/oauth/token".freeze
  PRODUCTION_OAUTH_URL = "https://apis-sandbox.fedex.com/oauth/token".freeze

  # Tracking URLs
  SANDBOX_TRACK_URL = "https://apis-sandbox.fedex.com/track/v1/trackingnumbers".freeze
  PRODUCTION_TRACK_URL = "https://apis.fedex.com/track/v1/trackingnumbers".freeze

  # Address Validatioin
  SANDBOX_ADDRESS_URL = "https://apis-sandbox.fedex.com/address/v1/addresses/resolve".freeze
  PRODUCTION_ADDRESS_URL = "https://apis.fedex.com/address/v1/addresses/resolve".freeze
end
