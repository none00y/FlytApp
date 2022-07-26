class User < ApplicationRecord
  attribute :user_type, :integer, default: -> { :basic_user }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :user_type

  enum user_type: {
    basic_user: 0,
    admin: 1
  }
  
  USER_TYPES = user_types.to_h { |k, _v| [k.to_sym, k] }.freeze

  def self.get_user_types
    USER_TYPES
  end

  def self.get_human_user_types
    USER_TYPES.to_h {|k,v|[User.human_enum_name(:user_types,k),k]}
  end

  def ability
    @ability ||= Ability.new(self)
  end
end
