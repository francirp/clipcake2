Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'],
           :scope => 'email,user_birthday,user_photos,friends_photos,friends_birthday', :display => 'popup'
end
