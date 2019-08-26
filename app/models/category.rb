# frozen_string_literal: true

class Category < ApplicationRecord
  before_validation :normalize_name
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  private

  def normalize_name
    return if name.nil?

    self.name = name.downcase.titleize.strip
  end
end
