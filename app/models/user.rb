class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum user_type: {
    basic_user: 0,
    admin: 1
  }

  USER_TYPES = user_types.to_h {|k,v| [k.to_sym,k]}.freeze

  def self.get_user_types
    USER_TYPES
  end
end
