class WorksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def new
    @work = Work.new
  end

  def create
    @work = current_user.works.build(work_params)
    
    if @work.save
      flash[:success] = "作品が投稿されました!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy

  end

  private
    
    def work_params
      params.require(:work).permit(:title)
    end
end
