module Sunlight
  class Base
    def self.construct_url(api_method, params)
      "https://congress.api.sunlightfoundation.com/#{api_method}?#{hash2get(params)}"
    end
  end

  class District


    def self.get_from_lat_long(latitude, longitude)
      url = construct_url("districts/locate", {:latitude => latitude, :longitude => longitude})
      districts = districts_from_url(url)
      districts ? districts.first : nil
    end

    # Usage:
    #   Sunlight::District.all_from_zipcode(90210)    # returns array of District objects
    #
    def self.all_from_zipcode(zipcode)
      url = construct_url("districts/locate", {:zip => zipcode})
      districts_from_url(url)
    end
 def self.districts_from_url(url)

      if (result = get_json_data(url))

        districts = []
        result["results"].each do |district|
          districts << District.new(district["state"], district["district"])
        end

        districts

      else  
        nil
      end # if response.class

    end

     def self.get(params)

      if (params[:latitude] and params[:longitude])

        get_from_lat_long(params[:latitude], params[:longitude])

      elsif (params[:address])

        # get the lat/long from Google
        coordinates = Geocoder.coordinates(params[:address])
        get_from_lat_long(coordinates[0], coordinates[1])
      else
        nil # appropriate params not found
      end

    end
  end 
  class Legislator

    attr_accessor :first_name, :last_name, :phone, :website, :office, :chamber
    def self.all_where(params)
      url = construct_url("legislators", params)
      legislators_from_url(url)
    end

    def self.all_in_district(district)
      representative = Legislator.all_where(:state => district.state, :district => district.number).first
      senators = Legislator.all_where(:state => district.state, :chamber => 'senate')
      senators + [representative]
    end


   def self.legislators_from_url(url)
      if (result = get_json_data(url))

        legislators = []
        result["results"].each do |legislator|
          legislators << Legislator.new(legislator)
        end

        legislators

      else  
        nil
      end # if response.class
   end
   
    
  end
  
end
