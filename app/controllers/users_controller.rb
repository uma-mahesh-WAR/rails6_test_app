class UsersController < ApplicationController

	def index
		@users=User.all
	end
	

	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
		@articles = @user.articles
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = 'Profile updated successfully'
      redirect_to @user
		else
			render 'edit'
		end
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = "User SignedUp Successfully, Welcome to Alpha Blog #{@user.username}"
			redirect_to articles_path
		else
			render 'new'
		end
	end

	def destroy
		@user=User.find(params[:id])
		if @user.destroy
			flash[:notice]="User profile deleted successfully"
			redirect_to root_path
		else
			render 'index'
		end
	end

	private

	def user_params
		params.require(:user).permit(:username, :email, :password)
	end
end
