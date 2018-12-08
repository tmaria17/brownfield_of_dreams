class UsersController < ApplicationController
  def show
    @user_facade = UserDashboardFacade.new(current_user)
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def update
    current_user.find_or_create_from_auth_hash(current_user, auth_hash)
    redirect_to dashboard_path
  end

  def destroy
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :token)
  end

end
