class UsersController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    @posts = Post.includes(:likes).order("likes.created_at desc").all
  end

  def new
  end

  def create
  	@user = User.new(newUser_params)
  	if @user.save 
      session[:user_id] = @user.id
  		redirect_to "/bright_ideas"
  	else
  		flash[:errors] = @user.errors.full_messages
  		redirect_to '/main'
  	end
  end

  def login
  	@user = User.find_by_email(params[:email])

  	if @user && @user.authenticate(params[:password])
  		session[:user_id] = @user.id
  		redirect_to "/bright_ideas"
  	else
  		flash[:errors] = ["Incorrect Login Information"]
  		redirect_to '/main'
  	end
  end 

  def show
   @user = User.find_by_id(params[:id]) 
   @post = Post.find_by_id(params[:id])
  end

  def destroy
    reset_session
    redirect_to '/main'
  end 

  private 
  	def newUser_params
  		params.require(:user).permit(:name, :alias, :email, :password, :password_confirmation) 
  	end

  	def loginUser_params
  		params.require(:user).permit(:email, :password)
  	end
end
