class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to books_path
    end
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      flash.now[:notice] = "You have failed to update."
      render :edit
    end
  end

  def index
    @user = current_user
    @users = User.all
    @books = @user.books
    @book = Book.new
  end

private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end