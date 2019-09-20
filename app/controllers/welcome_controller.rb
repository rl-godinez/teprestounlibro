# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @books = Book.approved_books.sample(6)
  end

  def terms_conditions; end
end
