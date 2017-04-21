class LikesController < ApplicationController
	def create
		Like.create(like_params)
  		redirect_to '/bright_ideas'
	end

	private
		def like_params
			params.require(:like).permit(:post_id).merge(user: User.find(session[:user_id]))
		end
end
