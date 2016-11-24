class User < ActiveRecord::Base

  has_many :calls
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :twitter, :google_oauth2]

  def self.from_omniauth(auth)
    provider = auth.provider
  where(provider: provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.set_image_and_profile(provider, auth)
  end
  end

  def set_image_and_profile(provider, auth)
    uid = auth.uid
    self.picture = "http://res.cloudinary.com/dm0czpc8q/image/gplus/c_thumb,e_improve,g_face,h_90,r_max,w_90/#{uid}.png"
    if provider == 'facebook'
      set_facebook_profile(uid)
    elsif provider == 'twitter'
      set_twitter_profile(auth)
    elsif provider == 'google_oauth2'
      set_google_profile(uid)
    end
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

  def set_twitter_profile(auth)
    self.profile = auth.info.try(:urls).try(:Twitter)
  end
  
end
 
