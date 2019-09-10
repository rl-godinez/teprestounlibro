# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  add_flash_types(:success, :info, :warning, :danger)
end
