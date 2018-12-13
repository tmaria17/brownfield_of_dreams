class SearchController < ApplicationController
  def index
    if params[:github_handle]
      @invitee = Search.new(params[:github_handle],current_user.token).invitee_info
        if @invitee[:email] != nil
          flash[:success] = "Successfully sent invite!"
          GithubMailer.invite(@invitee, current_user).deliver_now
        else
          flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
        end
      redirect_to dashboard_path
   end
  end
end
