class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:strava]

  has_one_attached :photo

  def self.create_from_provider_data(provider_data)
    # raise
    email = provider_data.info.name.split(" ").join.downcase + provider_data.uid + "@figz.com"
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = email
      user.password = Devise.friendly_token[0, 20]
      user.strava_picture_url = provider_data.extra.raw_info.profile
    end
  end
end
