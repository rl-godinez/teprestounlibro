require 'simplecov'
SimpleCov.start do
  'rails'
  'channels'
end

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class CarrierWave::Uploader::Base
  def remove!
    #do not remove fixture
  end

    # def store!
    #   # Not storing uploads in the tests
    # end
end

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  #parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  CarrierWave.root = Rails.root.join('test/fixtures/files')

  def after_teardown
    super
    CarrierWave.clean_cached_files!(0)
  end
  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end
