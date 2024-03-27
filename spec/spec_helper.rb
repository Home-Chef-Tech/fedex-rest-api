require "rspec"
require "bundler/setup"
require "fedex_rest_api"
require "support/vcr"
require "support/credentials"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.filter_run_excluding :production unless fedex_production_credentials
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
