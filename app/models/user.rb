class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:strava]
  
  acts_as_voter

  has_one_attached :photo
  has_many :routes, dependent: :destroy
  has_many :comments

  def self.create_from_provider_data(provider_data)
    email = provider_data.info.name.split(" ").join.downcase + provider_data.uid + "@figz.com"

    user_params ={}
    user_params[:email] = email
    user_params[:strava_picture_url] = provider_data.extra.raw_info.profile

    user = User.find_by(provider: provider_data.provider, uid: provider_data.uid)
    user ||= User.find_by(email: email)

    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0, 20]
      user.save
    end
    return user
  end
end
