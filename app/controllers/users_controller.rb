class UsersController < ApplicationController
  def index
  end
  def test
    respond_to do |format|
      format.js { render "users/index.js.erb", layout:false }
    end
  end
end 