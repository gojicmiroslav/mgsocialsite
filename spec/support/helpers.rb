require 'support/helpers/session_helpers'
require 'support/helpers/registration_helpers'


RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
  config.include Features::RegistrationHelpers, type: :feature
end