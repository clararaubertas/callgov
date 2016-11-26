class District < Sunlight::District

  def self.get_from_lat_long(latitude, longitude)
    url = Sunlight::Base.construct_url(
      "districts/locate",
      {:latitude => latitude, :longitude => longitude})
    districts = districts_from_url(url)
    districts ? districts.first : nil
  end

  def self.districts_from_url(url)
    if (result = get_json_data(url))
      districts = []
      result["results"].each do |district|
        districts << self.new(district["state"], district["district"])
      end
      districts
    else  
      nil
    end # if response.class
  end

  def self.get(address)
    coordinates = Geocoder.coordinates(address)
    get_from_lat_long(coordinates[0], coordinates[1]) if coordinates
  end
  
end 

