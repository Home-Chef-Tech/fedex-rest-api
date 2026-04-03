# frozen_string_literal: true

require "fedex_rest_api/base"

class FedexRestApi::Shipment
  attr_reader :shipment_object, :environment

  SHIP_URL = "/ship/v1/shipments"

  def initialize(shipment_object, environment: FedexRestApi::Base::SANDBOX)
    @shipment_object = shipment_object
    @environment = environment
  end

  def label
    response = HTTParty.post(env_url,
    headers: {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{shipment_object.access_token}"
    },
      body: shipment_object.body.to_json
    )

    error_message = response['errors'] || response['error_description']
    raise FedexRestApi::ApiError.new(error_message) if error_message
    response
  end

  private

  def env_url
    if environment == FedexRestApi::Base::PRODUCTION_ENV
      "#{FedexRestApi::Base::PRODUCTION_URL}#{SHIP_URL}"
    else
      "#{FedexRestApi::Base::SANDBOX_URL}#{SHIP_URL}"
    end
  end
end
