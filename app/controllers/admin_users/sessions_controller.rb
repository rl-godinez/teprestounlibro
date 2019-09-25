# frozen_string_literal: true

module AdminUsers
  class SessionsController < Devise::SessionsController
    protected

    def after_sign_in_path_for(*)
      admin_root_path
    end
  end
end
