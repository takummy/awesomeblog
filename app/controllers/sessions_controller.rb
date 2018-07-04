class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email])

  	if user && user.authenticate(params[:session][:password])

  		log_in user
  		flash[:success] = "You successfully logged in."
  		# redirect_to user
      redirect_back_or(user)

  	else
  		flash[:danger] = "User doesn't exist."
  		render "new"
  	end
  end

  def destroy
  	log_out
  	flash[:info] = "You successfully logged out."
    redirect_to login_url
  end
end
