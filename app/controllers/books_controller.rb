# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :find_book, only: %i[show edit update destroy require_book_owner]
  before_action :authenticate_user!
  before_action :require_book_owner, only: %i[show edit update destroy]

  def index
    @books = Book.all
  end

  def show; end

  def new
    @book = Book.new
  end

  def edit; end

  def create
    @book = Book.new(book_params)
    @book.user = current_user

    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      flash.now[:danger] = @book.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      flash.now[:danger] = @book.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, notice: 'Book was successfully destroyed.'
  end

  private

  def find_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:name, :description, :status, category_ids: [])
  end

  def require_book_owner
    redirect_to books_url, alert: "Hey! you can't edit this book" unless @book.user == current_user
  end
end
