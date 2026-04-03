require "fedex_rest_api/base"

class FedexRestApi::ShipmentObject
  attr_reader :access_token,
              :account_number,
              :label_response_options,
              :shipper,
              :recipients,
              :pickup_type,
              :service_type,
              :packaging_type,
              :shipping_charges_payment,
              :label_specification,
              :requested_package_line_items,
              :ship_datestamp,
              :total_weight

  def initialize(shipment_params)
    @access_token = shipment_params[:access_token]
    @account_number = shipment_params[:account_number]
    @shipper = shipment_params[:shipper]
    @recipients = shipment_params[:recipients] || []
    @ship_datestamp = shipment_params[:ship_datestamp]
    @label_response_options = shipment_params[:label_response_options] || "LABEL"
    @pickup_type = shipment_params[:pickup_type] || "USE_SCHEDULED_PICKUP"
    @service_type = shipment_params[:service_type] || "GROUND_HOME_DELIVERY"
    @packaging_type = shipment_params[:packaging_type] || "YOUR_PACKAGING"
    @shipping_charges_payment = shipment_params[:shipping_charges_payment] || { payment_type: "SENDER" }
    @label_specification = shipment_params[:label_specification] || { label_stock_type: "STOCK_4X6", image_type: "ZPLII" }
    @total_weight = shipment_params[:total_weight].nil? ? 15.to_f : shipment_params[:total_weight].to_f
    @requested_package_line_items = shipment_params[:requested_package_line_items] || [{ weight: { value: total_weight, units: "LB" } }]
  end

  def body
    {
      labelResponseOptions: label_response_options,
      accountNumber: {
        value: account_number
      },
      requestedShipment: {
        shipDatestamp: ship_datestamp,
        shipper: shipper_info(shipper),
        recipients: recipients.map { |recipient| recipient_info(recipient) },
        pickupType: pickup_type,
        serviceType: service_type,
        packagingType: packaging_type,
        shippingChargesPayment: {
          paymentType: shipping_charges_payment[:payment_type]
        },
        labelSpecification: {
          labelStockType: label_specification[:label_stock_type],
          imageType: label_specification[:image_type]
        },
        requestedPackageLineItems: requested_package_line_items,
        totalWeight: total_weight
      },
    }
  end

  private

  def shipper_info(location)
    {
      address: {
        streetLines: location[:address][:street_lines],
        city: location[:address][:city],
        stateOrProvinceCode: location[:address][:state_or_province_code],
        postalCode: location[:address][:postal_code],
        countryCode: location[:address][:country_code],
        personName: location[:customer_name]
      },
      contact: {
        phoneNumber: location[:contact][:phone_number],
        companyName: location[:contact][:company_name]
      }
    }
  end

  def recipient_info(location)
    {
      address: {
        streetLines: location[:address][:street_lines],
        city: location[:address][:city],
        stateOrProvinceCode: location[:address][:state_or_province_code],
        postalCode: location[:address][:postal_code],
        countryCode: location[:address][:country_code]
      },
      contact: {
        phoneNumber: location[:contact][:phone_number],
        personName: location[:contact][:person_name]
      }
    }
  end
end
