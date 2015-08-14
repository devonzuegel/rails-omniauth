# encoding: utf-8
require 'quiet_webkit'

Capybara.asset_host        = 'http://localhost:3000'
Capybara.javascript_driver = :quiet_webkit
Capybara.current_driver    = Capybara.javascript_driver
