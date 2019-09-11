require "test_helper"
require 'webdrivers'
require 'webdrivers/chromedriver'

if ENV["CI"]
  Webdrivers::Chromedriver.required_version = "75.0.3770.8"
else
  Webdrivers::Chromedriver.update
end

Capybara.register_driver :headless_chrome do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new

  options.add_argument("--headless")
  options.add_argument("--no-sandbox")
  options.add_argument("--disable-gpu")
  options.add_argument("--disable-dev-shm-usage")
  options.add_argument("--window-size=1920,1080")

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :headless_chrome

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :headless_chrome
end
