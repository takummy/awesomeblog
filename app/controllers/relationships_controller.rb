class RelationshipsController < ApplicationController

	def create
		user = User.find(params[:followed_id])
		current_user.follow(user)
		flash[:success] = "You followed #{user.name}."

		redirect_to user
	end

	def destroy
		user = Relationship.find(params[:id]).followed
		current_user.unfollow(user)

		flash[:info] = "You unfollowed #{user.name}."
		redirect_to user
	end

end
