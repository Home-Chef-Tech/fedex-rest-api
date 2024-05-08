require "fedex_rest_api/base"

class FedexRestApi::AddressObject
  attr_reader :access_token, :addresses

  def initialize(address_params)
    @access_token = address_params[:access_token]
    @addresses = address_params[:addresses] || []
  end

  def address_objects
    addresses.map do |address|
      {
        address: {
          "streetLines": [address.string(nil, format: :short)],
          "city": address.city,
          "stateOrProvinceCode": address.state,
          "postalCode": address.zip,
          "countryCode": "USA"
        }
      }
    end
  end
end
