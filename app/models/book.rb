# frozen_string_literal: true

class Book < ApplicationRecord
  validates_presence_of :name, :description

  belongs_to :user
end
