require "fedex_rest_api/base"

class FedexRestApi::Address
  attr_reader :address_object

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
        "addressesToValidate": [
          {
            "address": {
              # address_object[:address]
              "streetLines": [
                "7372 PARKRIDGE BLVD",
                "APT 286",
                "2903 sprank"
                ],
              "city": "IRVING",
              "stateOrProvinceCode": "TX", # not required
              "postalCode": "75063-8659"
            },
          }
        ]
      }.to_json
    )

    raise FedexRestApi::ApiError if response['errors'] || response['error_description']
    response
  end

  def env_url
    if address_object[:environment] == FedexRestApi::Base::PRODUCTION_ENV
      FedexRestApi::Base::PRODUCTION_ADDRESS_URL
    else
      FedexRestApi::Base::SANDBOX_ADDRESS_URL
    end
  end
end
