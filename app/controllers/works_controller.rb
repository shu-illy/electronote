# frozen_string_literal: true

class WorksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def new
    @work = Work.new
  end

  def create
    @work = current_user.works.build(work_params)

    if @work.save
      flash[:success] = '作品が投稿されました!'
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'new'
    end
  end

  def destroy
    @work.destroy
    flash[:success] = '投稿を削除しました'
    redirect_back(fallback_location: root_url)
  end

  private

  def work_params
    params.require(:work).permit(:title, :description, :circuit)
  end

  def correct_user
    @work = current_user.works.find_by(id: params[:id])
    redirect_to root_url if @work.nil?
  end
end
