# frozen_string_literal: true

json.extract! book, :id, :name, :description, :status, :created_at, :updated_at
json.url book_url(book, format: :json)
