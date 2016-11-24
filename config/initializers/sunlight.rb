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
        if coordinates
          get_from_lat_long(coordinates[0], coordinates[1])
        end
      else
        nil # appropriate params not found
      end
    end
  end 

  class Legislator

    attr_accessor :first_name, :last_name, :phone, :website, :office, :chamber

    def party_name
      if party == 'R'
        'republican'
      elsif party == 'D'
        'democrat'
      end
    end
    
    def display_image
      if twitter_id
        "<img src='http://res.cloudinary.com/dm0czpc8q/image/twitter_name/c_thumb,e_improve,g_face,h_100,r_max,w_100/#{twitter_id}.png' class='rep-image #{party_name}' />".html_safe
      elsif facebook_id
        "<img src='http://res.cloudinary.com/dm0czpc8q/image/facebook/c_thumb,e_improve,g_face,h_100,r_max,w_100/#{facebook_id}.png' class='rep-image #{party_name}' />".html_safe
      end
    end
    
    def display_name
      title = (chamber == 'senate') ? "Senator" : "Representative"
      my_district = (chamber == 'house') ? district : ""
      "#{title}<br /> #{first_name} #{last_name}<br /> (#{party}-#{state}#{(chamber == 'house') ? " " : ""}#{district})".html_safe
    end
    
    def self.all_where(params)
      url = construct_url("legislators", params)
      legislators_from_url(url)
    end

    def self.all_in_district(district)
      if district
        representative = Legislator.all_where(:state => district.state, :district => district.number).first
        senators = Legislator.all_where(:state => district.state, :chamber => 'senate')
        senators + [representative]
      else
        []
      end
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
