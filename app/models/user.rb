class User < ActiveRecord::Base

  has_many :services
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, #:omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  #:omniauth_providers => [:google_oauth2, :twitter]

  #devise :omniauthable,
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def create_from_oauth(oauth)
    services.build(provider: oauth["provider"],
                    uid: oauth["uid"])
  end

  def password_required?
    (services.empty? || !password.blank?) && super
  end

end
