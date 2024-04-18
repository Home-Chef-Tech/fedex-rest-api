def fedex_tracking_credentials
  @fedex_tracking_credentials ||= credentials["tracking_development"]
end

def fedex_address_credentials
  @fedex_address_credentials ||= credentials["address_development"]
end

def fedex_production_credentials
  @fedex_production_credentials ||= credentials["production"]
end

private

def credentials
  @credentials ||= begin
    YAML.load_file("#{File.dirname(__FILE__)}/../config/fedex_credentials.yml")
  end
end
