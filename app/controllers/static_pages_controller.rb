# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    return unless logged_in?

    @work = current_user.works.build
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def contact
  end

  def help
  end
end
