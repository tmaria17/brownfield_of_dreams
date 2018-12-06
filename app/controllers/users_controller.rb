class UsersController < ApplicationController
  def show
    @user_facade = UserDashboardFacade.new(current_user)
  end

  def new
    @user = User.new
  end

  def create
    if params[:github_handle]
      binding.pry
      FriendNotifierMailer.inform(current_user, params[:email]).deliver_now
      flash[:notice] = "Successfully sent invite!"
      redirect_to dashboard_path
    else
      user = User.create(user_params)
      if user.save
        session[:user_id] = user.id
        redirect_to dashboard_path
      else
        flash[:error] = 'Username already exists'
        render :new
      end
    end

  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
