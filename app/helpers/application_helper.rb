# frozen_string_literal: true
#
module ApplicationHelper
  def flash_helper(name)
    case name
    when 'notice'
      'alert-success'
    when 'alert'
      'alert-danger'
    end
  end
end

