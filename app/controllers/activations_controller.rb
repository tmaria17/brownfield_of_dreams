class ActivationsController<ApplicationController
  def update
    user = User.find_by(activation_token: params[:token])
    if user
      session[:user_id] = user.id
      user.validate_email
      flash[:success] = "Thank you, your account is now activated."
      redirect_to dashboard_path
    end
  end

end
