class ActivationsController<ApplicationController
  def confirm_email
    user = User.find_by(activation_token: params[:token])
    if user
      user.validate_email
      user.save(validate: false)
      redirect_to dashboard_path
    end
  end
end
