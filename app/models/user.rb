class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  attr_accessor :login
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2], authentication_keys: [:login]
  has_many :orders
  has_many :rider_amounts
  has_many :addresses
  enum role: [:super_admin, :normal_user, :chef, :moderator_user, :rider]
  enum gender: [:male, :female]
  enum status: [:active, :inactive]

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_presence_of :email
  validates_uniqueness_of :phone
  # , unless: -> { from_omniauth? }
  has_many :chef_categories
  has_many :categories, through: :chef_categories 
  has_many :chef_avalibilities
  has_many :chef_category_items, through: :chef_categories
  has_many :mess
  has_many :mess_items, through: :mess
  has_many :assign_items
  has_many :issued_items, through: :assign_items, source: :user, foreign_key: :chef_id
  has_many :riders
  # user_roles.each do |k, v|
  #   define_method "#{k}?" do
  #     role == v
  #   end
  # end

  def role_name
  end

  def login=(login)
    @login = self.email
  end

  def login
    @login || self.phone || self.email
  end

  class << self

    def find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_hash).where(["lower(phone) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:phone) || conditions.has_key?(:email)
        where(conditions.to_hash).first
     end
    end

    def create_from_provider_data(provider_data)
      where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do | user |
        user.email = provider_data.info.email
        user.password = Devise.friendly_token[0, 20]
        user.first_name = provider_data.info.first_name
        user.last_name = provider_data.info.last_name
        user.skip_confirmation!
      end
    end

  end

  private

    def from_omniauth?
      provider && uid
    end

end
