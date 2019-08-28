# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :user
  has_many :book_categories
  has_many :categories, through: :book_categories

  validates_presence_of :name, :description, :category_ids
end
