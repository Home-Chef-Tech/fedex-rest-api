class FedexRestApi::Base
  def self.fetch_token
    response = HTTParty.post("https://apis-sandbox.fedex.com/oauth/token",
      headers: {
        'Content-Type' => 'application/x-www-form-urlencoded'
      },
      body: {
        client_id: "l71927121b3df94fb39be865f7794b35fa",
        client_secret: "0293e021dba142a095ef91a7cdf84d1a",
        grant_type: 'client_credentials'
      }
    )
  end
end
