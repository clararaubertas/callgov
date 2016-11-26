module Sunlight
  class Base
    def self.construct_url(api_method, params)
      "https://congress.api.sunlightfoundation.com/#{api_method}?#{hash2get(params)}"
    end
  end
end

