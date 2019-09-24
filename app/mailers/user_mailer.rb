# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def borrowed_book(book)
    @book = book
    mail(to: @book.user.email, subject: 'Somebody wants to read your book!')
  end

  def approved_book(book)
    @book = book
    mail(to: @book.user.email, subject: 'Your book has been approved!')
  end
end
