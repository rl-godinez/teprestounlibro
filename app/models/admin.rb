# frozen_string_literal: true

class Admin < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable

  validates :email, uniqueness: true
end
