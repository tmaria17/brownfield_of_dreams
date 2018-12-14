class ActivationsController<ApplicationController
  def edit
    user = User.find_by(activation_token: params[:token])
    if user
      user.validate_email
      flash[:success] = "Thank you, your account is now activated."
      redirect_to dashboard_path
    end
  end

end
