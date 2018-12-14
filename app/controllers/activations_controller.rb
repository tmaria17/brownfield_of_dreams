class ActivationsController<ApplicationController
  def edit
    user = User.find_by(activation_token: params[:id])
    if user
      session[:user_id] = user.id
      user.validate_email
      user.save
      flash[:success] = "Thank you, your account is now activated."
      redirect_to dashboard_path
    end
  end

end
