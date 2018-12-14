class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    if current_user == nil && tutorial[:classroom] == true
      flash[:error] = "Please log in to view this tutorial."
      redirect_to tutorials_path
    elsif tutorial.videos == []
      flash[:error] = "This tutorial has no videos!"
      redirect_to dashboard_path
    else
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    end
  end

  def index
    if current_user == nil
      @tutorials = TutorialFacade.new(Tutorial.all.where(classroom: false))
    elsif current_user != nil
      @tutorials = TutorialFacade.new(Tutorial.all)
    end
  end

end
