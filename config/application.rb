require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UserTracking
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.time_zone = 'Brasilia'

    config.i18n.available_locales = %i[pt-BR]
    config.i18n.default_locale = :'pt-BR'

    config.encoding = 'utf-8'

    config.autoload_paths += Dir[Rails.root.join('app', 'models', '{**}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'services')]
    config.autoload_paths += Dir[Rails.root.join('app', 'validators')]

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '/cookie', headers: :any, methods: :post
        resource '/contacts', headers: :any, methods: :post
      end
    end
  end
end
