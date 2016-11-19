class User < ActiveRecord::Base

  has_many :calls
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :twitter, :google_oauth2]

  def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.picture = auth.info.image
    user.set_image_and_profile(auth.provider, auth)
  end
  end

  def set_image_and_profile(provider, auth)
    if provider == 'facebook'
      self.profile = "http://facebook.com/#{auth.uid}"
      self.picture = "http://res.cloudinary.com/dm0czpc8q/image/facebook/c_thumb,e_improve,g_face,h_90,r_max,w_90/#{auth.uid}.png"
    elsif provider == 'twitter'
      self.profile = auth.info.try(:urls).try(:Twitter)
      self.picture = "http://res.cloudinary.com/dm0czpc8q/image/twitter/c_thumb,e_improve,g_face,h_90,r_max,w_90/#{auth.uid}.png"
    elsif provider == 'google_oauth2'
      url = URI.parse("http://plus.google.com/#{auth.uid}") 
      if Net::HTTP.new(url.host, url.port).request_head(url.path).code == "200"
        self.profile = url
        self.picture = "http://res.cloudinary.com/dm0czpc8q/image/gplus/c_thumb,e_improve,g_face,h_90,r_max,w_90/#{auth.uid}.png"
      else
        self.picture = "http://res.cloudinary.com/dm0czpc8q/image/fetch/c_thumb,e_improve,g_face,h_90,r_max,w_90/#{self.picture}.png"
      end
    end
  end
  
end
 
