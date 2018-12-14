class Admin::BaseController < ApplicationController
  before_action :require_admin!

  def require_admin!
    raise ActionController::RoutingError.new('Not Found') unless current_user.admin?
  end
end
