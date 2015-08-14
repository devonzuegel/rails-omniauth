# lib/quiet_webkit.rb
Capybara::Webkit.configure do |config|
  # Enabling debug mode prints a log of everything the driver is doing.
  config.debug = false

  # Allow pages to make requests to any URL without issuing a warning.
  # By default, requests to outside domains (anything besides localhost) will
  # result in a warning. Several methods allow you to change this behavior.
  config.allow_unknown_urls

  # Timeout if requests take longer than 5 seconds
  config.timeout = 10

  # Don't raise errors when SSL certificates can't be validated
  config.ignore_ssl_errors

  # Don't load images
  config.skip_image_loading
end

# Suppresses plugin warnings from Qt/Xcode
class QuietWebkit
  IGNOREABLE = Regexp.new([
    'CoreText performance',
    'userSpaceScaleFactor',
    'FacebookVideoCalling.webplugin',
    'Internet Plug-Ins',
    'is implemented in bo'
  ].join('|'))

  def write(message)
    return 0 if message =~ IGNOREABLE
    Rails.logger message
    1
  end
end

Capybara.register_driver :quiet_webkit do |app|
  Capybara::Webkit::Driver.new(
    app,
    Capybara::Webkit::Configuration.to_hash.merge(stderr: QuietWebkit.new)
  )
end
