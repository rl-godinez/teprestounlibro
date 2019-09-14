# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :user
  has_many :book_categories
  has_many :categories, through: :book_categories

  mount_uploader :picture, PictureUploader

  validates_presence_of :name, :description, :category_ids, :picture

  enum status: %i[available not_available]

  def secondary_user
    User.find_by_id(secondary_user_id)
  end
end
