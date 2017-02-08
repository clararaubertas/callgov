# the Legislator class represents a senator or representative
class Legislator < Sunlight::Legislator

  def self.all_for(address)
    Legislator.all_in_district(District.get(address))
  end
  
  def party_name
    if party == 'R'
      'republican'
    elsif party == 'D'
      'democrat'
    end
  end
  
  def display_image
    image_host = "https://res.cloudinary.com/dm0czpc8q/image/"
    image_params = "c_thumb,e_improve,g_face,h_90,r_max,w_90"
    if twitter_id
      url = "#{image_host}twitter_name/#{image_params}/#{twitter_id}.png"    
    elsif facebook_id
      url = "#{image_host}facebook/#{image_params}/#{facebook_id}.png"    
    end
    "<img src='#{url}' class='rep-image #{party_name}' alt='' />".html_safe
  end

  def display_name
    title = (chamber == 'senate') ? "Sen." : "Rep."
    my_name = "#{title}<br /> #{first_name} #{last_name}<br />"
    cred = "(#{party}-#{state}#{(title == 'Sen.') ? '' : ' '}#{district})"
    "#{my_name} #{cred}".html_safe
  end
  
  def self.all_where(params)
    url = Sunlight::Base.construct_url("legislators", params)
    legislators_from_url(url)
  end

  def self.all_in_district(district)
    if district
      state = district.state
      Legislator.all_where(:state => state, :chamber => 'senate') +
        Legislator.all_where(
        :state => state,
        :district => district.number)
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
    end 
  end
  
end

