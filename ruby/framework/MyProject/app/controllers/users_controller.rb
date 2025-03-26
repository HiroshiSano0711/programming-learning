class UsersController < BaseController
  
  def index
    @users = User.find_all
    render 'index'
  end
end
