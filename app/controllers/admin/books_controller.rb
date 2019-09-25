# frozen_string_literal: true

module Admin
  class BooksController < Admin::ApplicationController
    def approve
      book = Book.find(params[:id])
      book.available!
      UserMailer.delay.approved_book(book)
      redirect_to admin_book_url(book), notice: 'Book was successfully approved.'
    end
  end
end
