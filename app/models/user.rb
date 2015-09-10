class User < ActiveRecord::Base
  has_many :bookings
  has_many :passengers, through: :bookings
  has_many :flights, through: :bookings

  def self.from_omniauth(auth)
    where(provider: auth.provider, uuid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uuid = auth.uid
      user.profile_url = auth.info.image
      user.name = auth.info.name
      user.email = auth.info.email
      user.auth_token = auth.credentials.token
      user.save!
    end
  end
end
