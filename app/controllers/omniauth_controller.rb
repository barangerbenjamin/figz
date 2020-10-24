class OmniauthController < Devise::OmniauthCallbacksController

  def strava
      user = User.create_from_provider_data(request.env['omniauth.auth'])
      if user.persisted?
          sign_in_and_redirect user
          set_flash_message(:notice, :success, kind: 'Strava') if is_navigational_format?
      else
          flash[:error] = 'There was a problem signing you in through Strava'
          redirect_to new_user_registration_url
      end
  end
end
