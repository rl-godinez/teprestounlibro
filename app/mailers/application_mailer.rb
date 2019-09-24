# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@teprestounlibro.com'
  layout 'mailer'
end
