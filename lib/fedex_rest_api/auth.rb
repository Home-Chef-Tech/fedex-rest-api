# frozen_string_literal: true

require "fedex_rest_api/base"

class FedexRestApi::Auth
  attr_reader :credentials_object

  OAUTH_URL = "/oauth/token"

  def initialize(credentials_object)
    @credentials_object = credentials_object
  end

  def fetch_token
    response = HTTParty.post("#{env_url}",
      headers: {
        'Content-Type' => 'application/x-www-form-urlencoded'
      },
      body: {
        client_id: credentials_object[:client_id],
        client_secret: credentials_object[:client_secret],
        grant_type: credentials_object[:grant_type]
      }
    )

    raise FedexRestApi::ApiError if response['errors']
    response
  end

  def env_url
    if credentials_object[:environment] == FedexRestApi::Base::PRODUCTION_ENV
      "#{FedexRestApi::Base::PRODUCTION_URL}#{OAUTH_URL}"
    else
      "#{FedexRestApi::Base::SANDBOX_URL}#{OAUTH_URL}"
    end
  end
end
