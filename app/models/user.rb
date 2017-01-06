class User < ActiveRecord::Base

  has_many :calls
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :omniauthable,
         :omniauth_providers => [:facebook, :twitter, :google_oauth2]

  def self.from_omniauth(auth)
    provider = auth.provider
    where(uid: auth.uid, provider: provider).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.set_image_and_profile(provider, auth)
    end
  end

  def self.translate_provider_for_image(provider)
    case provider
    when "google_oauth2"
      "fetch"
    when "twitter"
      "twitter_name"
    else
      provider
    end
  end
  
  def set_image_and_profile(provider, auth)
    uid = auth.uid
    image_provider = User.translate_provider_for_image(provider)
    set_image(image_provider, uid, auth)
    set_profile(provider, auth.info, uid)
  end

  def set_profile(provider, info, uid)
    case provider
    when "google_oauth2"
      set_google_profile(uid)
    when "twitter"
      set_twitter_profile(info)
    when "facebook"
      set_facebook_profile(uid)
    else
      nil # do nothing
    end
  end

  def set_image(provider, uid, auth)
    image_host = "https://res.cloudinary.com/dm0czpc8q/image/"
    image_params = "c_thumb,e_improve,g_face,h_90,r_max,w_90"
    info = auth.try(:info)
    if provider == 'twitter_name'
      adjusted_uid = info.try(:nickname)
    elsif provider == 'fetch'
      adjusted_uid = info.try(:image)
    else
      adjusted_uid = uid
    end
    self.picture =
      "#{image_host}#{provider}/#{image_params}/#{adjusted_uid}.png"    
  end

  def set_facebook_profile(uid)
    self.profile = "http://facebook.com/#{uid}"
  end

  def set_google_profile(uid)
    url = "https://plus.google.com/#{uid}"
    response = Net::HTTP.get_response(URI.parse(url)).code
    if (response == '200')  || (response == '302')
      self.profile = url
    end
  end

  def set_twitter_profile(info)
    self.profile = info.try(:urls).try(:Twitter)
  end
  
end
 
