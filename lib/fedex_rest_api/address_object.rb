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
          streetLines: address[:address][:street],
          city: address[:address][:city],
          stateOrProvinceCode: address[:address][:state],
          postalCode: address[:address][:zip],
          countryCode: address[:address][:country]
        }
      }
    end
  end
end
