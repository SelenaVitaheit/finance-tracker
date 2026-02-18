# Заглушка для tzinfo/data на Linux
if ENV['RAILS_ENV'] == 'production'
  module TZInfo
    module Data
      # Пустой модуль — заменяет отсутствующий гем
    end
  end
end

require_relative "boot"

require "rails"

require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine" 
# require "rails/test_unit/railtie"


Bundler.require(*Rails.groups)

module FinanceTracker
  class Application < Rails::Application
    config.load_defaults 8.1
    config.time_zone = 'UTC'
    config.active_record.default_timezone = :utc
    config.autoload_lib(ignore: %w[assets tasks])
    config.generators.system_tests = nil
  end
end
