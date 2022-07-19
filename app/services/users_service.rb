class UsersService 
  attr_reader :user

  def initialize ( user_params, user = nil )
    @user_params = user_params
    @user = user.present? ? user : User.new(user_params)
  end
  
  def update_user
    @user.update(@user_params)
  end

  def create_user
    @user.save
  end

end