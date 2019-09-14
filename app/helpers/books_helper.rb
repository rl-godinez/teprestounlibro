# frozen_string_literal: true

module BooksHelper
  def able_to_borrow?(book, current_user)
    book.user != current_user && book.secondary_user_id.nil? && Book.where(secondary_user_id: current_user.id).count.zero?
  end

  def assigned_to(book)
    if @book.secondary_user.present?
      secondary_user = "<p>This book was assigned to: <strong>#{book.secondary_user.email}</strong></p>"
      secondary_user.html_safe
    end
  end
end
