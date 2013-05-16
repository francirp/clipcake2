class User < ActiveRecord::Base
    has_many :books, :through => :roles
    has_many :photos
    has_many :roles
    has_many :texts
    has_many :pages
    has_many :friends


def self.from_omniauth(auth)
  where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
end

def self.create_from_omniauth(auth)
  create! do |user|
    if User.where(:uid => auth.uid).present? != true
        user.access_token = auth.credentials.token
        user.provider = auth.provider
        user.uid = auth.uid
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.full_name = auth.info.name
        user.email = auth.info.email
        user.is_activated = true
        # user.avatar = auth.info.avatar
    else
        u = User.where(:uid => auth.uid)
        u.access_token = auth.credentials.token
        u.provider = auth.provider
        u.first_name = auth.info.first_name
        u.last_name = auth.info.last_name
        u.full_name = auth.info.name
        u.email = auth.info.email
        u.is_activated = true
    end
  end
end


end
