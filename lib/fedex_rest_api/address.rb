# frozen_string_literal: true

require "fedex_rest_api/base"

class FedexRestApi::Address
  attr_reader :address_object, :environment

  ADDRESS_VALIDATION_URL = "/address/v1/addresses/resolve"

  def initialize(address_object, environment: FedexRestApi::Base::SANDBOX)
    @address_object = address_object
    @environment = environment
  end

  def validate
    response = HTTParty.post(env_url,
      headers: {
        "Content-Type" => 'application/json',
        "Authorization" => "Bearer #{address_object.access_token}"
      },
      body: {
        "addressesToValidate": address_object.addresses
      }.to_json
    )

    raise FedexRestApi::ApiError if response['errors'] || response['error_description']
    response
  end

  def env_url
    if environment == FedexRestApi::Base::PRODUCTION_ENV
      "#{FedexRestApi::Base::PRODUCTION_URL}#{ADDRESS_VALIDATION_URL}"
    else
      "#{FedexRestApi::Base::SANDBOX_URL}#{ADDRESS_VALIDATION_URL}"
    end
  end
end
