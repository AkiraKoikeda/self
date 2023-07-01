class BooksController < ApplicationController
  def index
    @user = current_user
    @book = Book.new
    @books = Book.all

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "New post was successed"
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def destroy
    @book = Book.find(params[:id])
    @book.delete
    redirect_to "/books"
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Update was successed"
      redirect_to book_path(@book)
    else
      render :edit
    end
  end
end

private

def book_params
  params.require(:book).permit(:title, :body)
end
