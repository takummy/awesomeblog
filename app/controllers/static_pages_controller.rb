class StaticPagesController < ApplicationController
  def home
  	if logged_in?
      @microposts = current_user.feed.paginate(page: params[:page], per_page: 10)
  		# @microposts = current_user.microposts.paginate(page: params[:page], per_page: 15)
  		@micropost = current_user.microposts.new
  	end
  end

  def help
  end

  def about
  end
end
