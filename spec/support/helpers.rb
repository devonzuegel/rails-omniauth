RSpec.configure do |config|
  config.include SpecUtils
  config.include ElasticSearchSupport
  config.include EntrySupport
  config.include Omniauth
  config.include Omniauth::Mock
  config.include Omniauth::SessionHelpers, type: :feature
  config.include WaitForAjax, type: :feature
end
OmniAuth.config.test_mode = true
