class User < ApplicationRecord
  has_many :notes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  validates_presence_of :first_name
  validates_presence_of :last_name

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    unless user
      user = User.create(
      email: data['email'],
      first_name: data['first_name'],
      last_name: data['last_name'],
      password: Devise.friendly_token[0, 20]
      )
    end
    user
  end
end
