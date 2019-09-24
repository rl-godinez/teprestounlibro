# frozen_string_literal: true

class AdminUserMailer < ApplicationMailer
  default to: -> { AdminUser.pluck(:email) }

  def book_approval(book)
    @book = book
    mail(subject: 'A new book needs your approval.')
  end
end
