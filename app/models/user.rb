class User < ActiveRecord::Base
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
      user.profile = auth.try(:extra).try(:raw_info).try(:link)
    elsif auth.provider == 'twitter'
      user.profile = auth.info.try(:urls).try(:Twitter)
    elsif auth.provider == 'google_oauth2'
      user.profile = auth.try(:extra).try(:raw_info).try(:profile)
    end

  end
end
  
end
 
