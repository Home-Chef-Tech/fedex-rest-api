require "fedex_rest_api/base"

class FedexRestApi::AddressObject
  attr_reader :access_token, :addresses_to_validate

  def initialize(address_params)
    @access_token = address_params[:access_token]
    @addresses_to_validate = address_params[:addresses] || []
  end

  def addresses
    addresses_to_validate.map do |address|
      {
        address: {
          "streetLines": [address[:street]],
          "city": address[:city],
          "stateOrProvinceCode": address[:state],
          "postalCode": address[:zip],
          "countryCode": "US"
        }
      }
    end
  end
end
