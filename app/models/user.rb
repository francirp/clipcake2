class User < ActiveRecord::Base
    has_many :books, :through => :roles
    has_many :photos
    has_many :roles
    has_many :texts
    has_many :pages
    has_many :friends

    def facebook
      puts "in facebook"
      @facebook ||= Facebook.new(access_token,uid,id)
    end

    def self.create_from_omniauth(auth)
        if User.where(:uid => auth.uid).present?
                user = User.where(:uid => auth.uid).first
                user.access_token = auth.credentials.token
                user.provider = auth.provider
                user.first_name = auth.info.first_name
                user.last_name = auth.info.last_name
                user.full_name = auth.info.name
                user.email = auth.info.email
                user.is_activated = true
                user.avatar = "#{auth.info.image}&type=large"
                user.save
                return user
        else
            create! do |user|
                user.access_token = auth.credentials.token
                user.provider = auth.provider
                user.uid = auth.uid
                user.first_name = auth.info.first_name
                user.last_name = auth.info.last_name
                user.full_name = auth.info.name
                user.email = auth.info.email
                user.is_activated = true
                user.avatar = "#{auth.info.image}&type=large"
            end
        end
    end


end
