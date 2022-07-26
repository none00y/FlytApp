class ApplicationController < ActionController::Base
  check_authorization unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def current_ability
    if current_user.nil?
      @current_ability = Ability.new(User.new(user_type: nil))
    else
      @current_ability ||= current_user.ability
    end
  end
end
