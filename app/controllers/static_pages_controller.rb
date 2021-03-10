class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @work = current_user.works.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def contact
  end

  def help
  end
end
