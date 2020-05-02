class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :ensure_correct_user, {only:[:edit,:update]}
	def index
		@book = Book.new
		@user = current_user
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		@book = Book.new
		@books = @user.books
	end

	def edit
		@user = current_user
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:success]='You have update user successfully.'
			redirect_to user_path(@user.id)
		else
			render :edit
		end
	end

    def ensure_correct_user
		@user = User.find(params[:id])
		if @user != current_user
		   redirect_to user_path(current_user.id)
		end
	end
    private
	def user_params
		params.require(:user).permit(:name,:profile_image,:introduction)
	end
end
