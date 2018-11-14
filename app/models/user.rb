class User < ApplicationRecord
  devise  :database_authenticatable,
          :registerable,
          :trackable,
          :recoverable,
          :rememberable,
          :validatable,
          :omniauthable,
          omniauth_providers: [:google_oauth2, :github],
          authentication_keys: [:login]

  has_one :profile, dependent: :destroy

  validates :name, presence: :true, uniqueness: { case_sensitive: false }
  validates_format_of :name, with: /^[a-zA-Z0-9_\-\.]*$/, :multiline => true

  attr_writer :login

  def login
    @login || self.name || self.email
  end
# ----------Authen.-----------
  def self.find_for_google(auth)
    user = User.find_by(email: auth.info.email)
    unless user
      user = User.create(
        name: auth.info.email.split('@')[0],
        email: auth.info.email,
        provider: auth.provider,
        uid: auth.uid,
        token: auth.credentials.token,
        password: Devise.friendly_token[0, 20],
        meta: auth.to_yaml
        )
    end
    user
  end

  def self.find_for_github_oauth(auth, signed_in_resource=nil)
    user = User.find_by(email: auth.info.email)
    unless user
      user = User.create(
        name: auth.info.nickname,
        email: auth.info.email,
        provider: auth.provider,
        uid: auth.uid,
        token: auth.credentials.token,
        password: Devise.friendly_token[0, 20],
        meta: auth.to_yaml
        )
    end
    user
  end

  protected
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:name) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
# ----------if users forget password, they can reset it.-----------
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:name].nil?
        where(conditions).first
      else
        where(name: conditions[:name]).first
      end
    end
  end
end

# https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address






