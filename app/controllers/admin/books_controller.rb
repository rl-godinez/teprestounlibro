# frozen_string_literal: true

module Admin
  class BooksController < Admin::ApplicationController
    def approve
      book = Book.find(params[:id])
      book.available!
      UserMailer.approved_book(book).deliver_later
      redirect_to admin_book_url(book), notice: 'Book was successfully approved.'
    end
  end
end
