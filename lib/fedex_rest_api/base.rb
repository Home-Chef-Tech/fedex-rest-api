class FedexRestApi::Base
  PRODUCTION_ENV = "production".freeze

  # Access Token URLs
  SANDBOX_OAUTH_URL = "https://apis-sandbox.fedex.com/oauth/token".freeze
  PRODUCTION_OAUTH_URL = "https://apis-sandbox.fedex.com/oauth/token".freeze

  # Tracking URLs
  SANDBOX_TRACK_URL = "https://apis-sandbox.fedex.com/track/v1/trackingnumbers".freeze
  PRODUCTION_TRACK_URL = "https://apis.fedex.com/track/v1/trackingnumbers".freeze
end
