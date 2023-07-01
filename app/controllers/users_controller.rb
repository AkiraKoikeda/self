class UsersController < ApplicationController
  def index
    @user = current_user
    @book = Book.new
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = Book.all
  end

  def edit
    @user =User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Update was successed"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

end

private

def user_params
  params.require(:user).permit(:name, :introduction)
end

def is_matching_login_user
  @user = User.find(params[:id])
  unless @user == current_user
    redirect_to user_path(current_user.id)
  end
end