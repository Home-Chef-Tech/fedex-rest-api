require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir  = File.expand_path('../../vcr', __FILE__)
  c.hook_into :webmock

  c.filter_sensitive_data('<CREDENTIALS>') { |interaction|
    interaction.request['body'].sub('string ', '')
  }
  c.filter_sensitive_data('<ACCESS OBJECT>') { |interaction|
    interaction.response['body'].sub('string ', '')
  }
  c.filter_sensitive_data('<AUTH>') { |interaction|
    interaction.request.headers['Authorization'][0] unless interaction.request.headers['Authorization'].nil?
  }
end

RSpec.configure do |c|
  c.around(:each, :vcr) do |example|
    name = underscorize(example.metadata[:full_description].split(/\s+/, 2).join("/")).gsub(/[^\w\/]+/, "_")
    VCR.use_cassette(name) { example.call }
  end
end

def underscorize(key) #:nodoc:
  key.to_s.sub(/^(v[0-9]+|ns):/, "").gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').gsub(/([a-z\d])([A-Z])/,'\1_\2').downcase
end


