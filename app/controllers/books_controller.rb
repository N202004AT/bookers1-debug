class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, {only: [:edit,:update,:destroy]}
  # GET /books
  # GET /books.json
  def name
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @booked = Book.find(params[:id])
    @book = Book.new
    @user = User.find(@booked.user_id)
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]='You have updated book successfully.'
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    redirect_to books_url, notice: 'Book was successfully destroyed.'
  end


  def ensure_correct_user
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.


    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :body)
    end
end
