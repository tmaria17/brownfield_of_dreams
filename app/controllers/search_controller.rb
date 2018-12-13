class SearchController < ApplicationController
  def index
    if params[:github_handle]
      @invitee = Search.new(params[:github_handle],current_user.token).invitee_info
      GithubMailer.invite(@invitee, current_user).deliver_now
        if @invitee[:email] != nil
          flash[:success] = "Successfully sent invite!"
        else
          flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
        end
      redirect_to dashboard_path
   end
  end
end
