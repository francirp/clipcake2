Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], :iframe => true,
           :scope => 'email,user_birthday,user_photos,friends_photos,friends_birthday', :secure_image_url => true
end
