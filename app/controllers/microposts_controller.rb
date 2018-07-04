class MicropostsController < ApplicationController
  
	before_action :require_login, only: [:create, :destroy]
	before_action :correct_user, only: :destroy
	
  def create
  	@micropost = current_user.microposts.create(micropost_params) 
  	if @micropost.save
  		flash[:success] = "Posted!"
  		redirect_to root_url
  	else
  		@microposts = current_user.feed.paginate(page: params[:page], per_page: 10)
  		render 'static_pages/home'
  	end
  end

  def destroy
  	@micropost = Micropost.find(params[:id])
  	@micropost.destroy
  	flash[:info] = "Delete post successfully."
  	redirect_to request.referrer || root_url
  end

  private
	def micropost_params
		params.require(:micropost).permit(:content, :picture)
	end

	def correct_user
		@micropost = current_user.microposts.find_by(id: params[:id])

		if @micropost.nil?
			flash[:danger] = "You are not allowed to do that."
			redirect_to root_url
		end
	end
end
