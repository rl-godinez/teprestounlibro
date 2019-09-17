# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :find_book, only: %i[show edit update destroy require_book_owner toggle_status assign verify_status]
  before_action :authenticate_user!, except: %i[index show]
  before_action :require_book_owner, only: %i[edit update destroy]
  before_action :verify_status, only: [:show]

  def index
    if params[:user_id].present?
      return redirect_to books_url unless current_user.present?
      return redirect_to user_books_url(current_user) unless current_user.id.to_s == params[:user_id]
    end

    @books = books
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

  def toggle_status
    @book.not_available? ? @book.available! : @book.not_available!

    @book.update(secondary_user_id: nil) if @book.available?

    redirect_to book_url(@book)
  end

  def assign
    @book.update(secondary_user_id: current_user.id)
    @book.not_available!
    redirect_to @book, notice: 'Thank you for select this book, we hope you enjoy it!'
  end

  private

  def books
    if params[:user_id].present?
      User.find(params[:user_id]).books
    else
      Book.approved_books
    end
  end

  def find_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:name, :description, :picture, category_ids: [])
  end

  def require_book_owner
    redirect_to books_url, alert: "Hey! you can't edit this book" unless @book.user == current_user
  end

  def verify_status
    redirect_to books_url, alert: 'The book you are looking for is not approved yet' if
      @book.pending_approval? && @book.user != current_user
  end
end
