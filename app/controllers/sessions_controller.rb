class SessionsController < ApplicationController
  def new
    @user ||= User.new
  end

  def create

      if
      user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = user.id
      redirect_to dashboard_path
    end
    # else
      # binding.pry
      # user = User.find_by(email: params[:session][:email])
      #  user && user.authenticate(params[:session][:password])
      # session[:user_id] = user.id
      # redirect_to dashboard_path
    # end
    # else
    #   flash[:error] = "Looks like your email or password is invalid"
    #   render :new
    # end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
