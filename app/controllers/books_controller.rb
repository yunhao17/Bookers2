class BooksController < ApplicationController
  

  def index
    @user = User.find(current_user.id)
    @book= Book.new
    @books= Book.all
  end

  def show
    @book = Book.new
    @books = Book.find(params[:id])
    @book_comment = BookComment.new
    @user= @books.user
  end
  
  def create
    @user = User.find(current_user.id)
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:success] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end
  
  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
            render :edit
    else
            redirect_to books_path
    end
  end
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:success] = "You have updated book successfully."
       redirect_to book_path(@book.id)
    else 
       render :edit
    end
  end

  def destroy
    @books = Book.find(params[:id])
    @books.destroy
    redirect_to books_path
    
  end
  
  private

  def book_params
    params.require(:book).permit(:title, :body,)
  end
end
