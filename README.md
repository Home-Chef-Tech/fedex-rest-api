# FedexRestApi

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/fedex_rest_api`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fedex_rest_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fedex_rest_api

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

To run specs, use rspec as normal (bundle exec rspec). BUT FIRST, you'll need some valid testing credentials. Within `spec/config`, create a file `fedex_credentials.yml` that mimics the structure and keys found in `fedex_credentials.example.yml`. Make sure your new file is `.gitignore`'d. Client ID and secret keys can be found within the FedEx Developer Portal (deets in 1PW) for each individual API. Grant type is `client-credientials` and the environment is `sandbox`. 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/fedex_rest_api.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
