# encoding: utf-8
Capybara.asset_host = 'http://localhost:3000'
Capybara.javascript_driver = :webkit
Capybara.current_driver = Capybara.javascript_driver

Capybara::Webkit.configure do |config|
  # Enable debug mode. Prints a log of everything the driver is doing.
  config.debug = false

  # By default, requests to outside domains (anything besides localhost) will
  # result in a warning. Several methods allow you to change this behavior.

  # Allow pages to make requests to any URL without issuing a warning.
  config.allow_unknown_urls

  # # Timeout if requests take longer than 5 seconds
  # config.timeout = 5

  # Don't raise errors when SSL certificates can't be validated
  config.ignore_ssl_errors

  # Don't load images
  config.skip_image_loading
end
