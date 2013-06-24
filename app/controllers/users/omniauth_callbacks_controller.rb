class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook

    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      sign_in @user # _and_redirect @user, :event => :authentication #this will throw if @user is not activated
      redirect_to books_url
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end

  end
end
