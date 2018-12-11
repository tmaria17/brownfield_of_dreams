class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end

  def index
    if current_user == nil
      @tutorials = TutorialFacade.new(Tutorial.all.where(classroom: false))
    elsif current_user != nil
      @tutorials = TutorialFacade.new(Tutorial.all)
    end
  end

end
