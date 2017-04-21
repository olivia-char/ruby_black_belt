class PostsController < ApplicationController
  def index
  	@user = User.find(session[:user_id])
  	@post = Post.find_by_id(params[:id])
  	@likes = @post.likes
  	@users = User.find_by_id(params[:id])

  end

  def create
  	@users = session[:user_id]
  	@posts = Post.new(post_params)
  	if @posts.save
  		redirect_to "/bright_ideas"
  	else
  		flash[:errors] = @secret.errors.full_messages
  		redirect_to "/bright_ideas"
  	end
  end

  def destroy
  	@user = session[:user_id]
 	Post.find(params[:id]).destroy
 	redirect_to "/bright_ideas"
  end 

  private
  	def post_params
  		params.require(:post).permit(:content).merge(user: User.find(session[:user_id])) 
  	end
end
