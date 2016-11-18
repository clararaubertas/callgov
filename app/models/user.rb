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
    if auth.provider == 'facebook'
      user.profile = "http://facebook.com/#{auth.uid}"
      user.picture = "http://res.cloudinary.com/dm0czpc8q/image/facebook/c_thumb,e_improve,g_face,h_90,r_max,w_90/#{auth.uid}.png"
    elsif auth.provider == 'twitter'
      user.profile = auth.info.try(:urls).try(:Twitter)
      user.picture = "http://res.cloudinary.com/dm0czpc8q/image/twitter/c_thumb,e_improve,g_face,h_90,r_max,w_90/#{auth.uid}.png"
    elsif auth.provider == 'google_oauth2'
      url = URI.parse("http://plus.google.com/#{auth.uid}") 
      if Net::HTTP.new(url.host, url.port).request_head(url.path).code == "200"
          user.profile = url
          user.picture = "http://res.cloudinary.com/dm0czpc8q/image/gplus/c_thumb,e_improve,g_face,h_90,r_max,w_90/#{auth.uid}.png"
      else
        user.picture = "http://res.cloudinary.com/dm0czpc8q/image/fetch/c_thumb,e_improve,g_face,h_90,r_max,w_90/#{user.picture}"
      end
    end

  end
end
  
end
 
