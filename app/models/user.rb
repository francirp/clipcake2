class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook,:instagram]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :first_name, :last_name, :full_name
    has_many :books, :through => :roles
    has_many :photos
    has_many :roles
    has_many :texts
    has_many :pages
    has_many :friends
    has_one :facebook, :dependent => :destroy

    # after_create do |user|
    #     email = UserMailer.welcome(@user)
    #     email.deliver
    # end

    def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
      if (signed_in_resource)
        logger.debug "current user #{signed_in_resource.id}"
      end
      facebook = Facebook.where(:uid => auth.uid).first
      if (not facebook.present?)
        facebook = Facebook.create(name:auth.extra.raw_info.name,
                                   uid:auth.uid,
                                   email:auth.info.email,
                                   avatar:"#{auth.info.image}&type=large"
                                   )
      end
      # always refresh oauth_token
      facebook.oauth_token = auth.credentials.token
      facebook.save
      user = facebook.user
      unless user
        user = User.create(full_name:auth.extra.raw_info.name,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20],
                           first_name:auth.info.first_name,
                           last_name:auth.info.last_name,
                           full_name:auth.info.name
                           )
        facebook.user = user
        facebook.save
      end
      user
    end


end
