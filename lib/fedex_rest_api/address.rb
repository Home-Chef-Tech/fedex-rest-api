require "fedex_rest_api/base"

class FedexRestApi::Address
  attr_reader :address_object

  ADDRESS_VALIDATION_URL = "/address/v1/addresses/resolve".freeze

  def initialize(address_object)
    @address_object = address_object
  end

  def validate
    response = HTTParty.post(env_url,
      headers: {
        "Content-Type" => 'application/json',
        "Authorization" => "Bearer #{address_object[:access_token]}"
      },
      body: {
        "addressesToValidate": [ # address_object[:addresses]
          {
            "address": {
              "streetLines": ["7372 PARKRIDGE BLVD", "APT 286"],
              "city": "IRVING",
              "stateOrProvinceCode": "TX",
              "postalCode": "75063-8659",
              "countryCode": "US"
            }
          }
        ]
      }.to_json
    )

    raise FedexRestApi::ApiError if response['errors'] || response['error_description']
    response
  end

  def env_url
    if address_object[:environment] == FedexRestApi::Base::PRODUCTION_ENV
      FedexRestApi::Base::PRODUCTION_ADDRESS_VALIDATION_URL
      "#{FedexRestApi::Base::PRODUCTION_URL}#{ADDRESS_VALIDATION_URL}"
    else
      "#{FedexRestApi::Base::SANDBOX_URL}#{ADDRESS_VALIDATION_URL}"
    end
  end
end
