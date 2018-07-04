class ApplicationController < ActionController::Base

	include SessionsHelper

	def require_login
		unless logged_in?
			store_location
			flash[:danger] = "Please log-in."
			redirect_to login_url
		end
	end

	def correct_user
		@user = User.find(params[:id])

		unless current_user?(@user)
			flash[:danger] = "Have no authority."
			redirect_to users_url
		end
	end

	def admin_user
		unless current_user.admin?
			flash[:danger] = "You are not allowed to do that."
			redirect_to root_url 
		end
	end
end
