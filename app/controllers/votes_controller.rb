class VotesController < ApplicationController

	def create
		@micropost = Micropost.find(params[:micropost_id])
		current_user.upvote(@micropost)
		# redirect_to request.referrer || root_path

		respond_to do |format|
			format.html { redirect_to root_url }
			format.js
		end
	end


	def destroy
		@micropost = Vote.find(params[:id]).micropost
		current_user.downvote(@micropost)
		# redirect_to request.referrer || root_path

		#vote = Vote.find(params[:id])
		#vote.destroy

		respond_to do |format|
			format.html { redirect_to root_url }
			format.js
		end
	end

	
end
