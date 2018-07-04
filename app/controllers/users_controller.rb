class UsersController < ApplicationController

	before_action :require_login, only: [:edit, :index, :update]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user, only: :destroy

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			log_in @user
			flash[:success] = "Welcome to Awesome Blog App"
			redirect_to @user
		else
			render "new"
		end
	end

	def show
		@user = User.find(params[:id])
		@microposts = @user.microposts.paginate(page: params[:page], per_page: 15)
	end

	def edit

	end

	def update
		
		if @user.update_attributes(user_params)
			flash[:success] = "Updated your information successfully."
			redirect_to @user
		else
			render "edit"
		end
	end

	def index
		@users = User.paginate(page: params[:page], per_page: 15)
	end

	def destroy
		user = User.find(params[:id])
		user.destroy
		flash[:info] = "Successfully deleted. user: #{user.email}"
		redirect_to users_url
	end

	def following
		@user = User.find(params[:id])
		@users = @user.following
		@title = "Following"
		render 'show_follow'
	end

	def followers
		@user = User.find(params[:id])
		@users = @user.followers
		@title = "Followers"
		render 'show_follow'
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
end