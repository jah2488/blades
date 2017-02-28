require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blades
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.active_record.primary_key = :uuid
  end
end

# module Elm
#   class Template < ::Tilt::Template
#     def prepare
#     end
#
#     def evaluate(scope, locals, &block)
#       f = "#{Rails.root}/tmp/output.js"
#       result = system "elm-make #{file} --output=#{f}"
#       if result
#         puts result
#         contents = `cat #{f}`
#         `rm #{f}`
#         contents
#       else
#         ""
#       end
#     end
#   end
# end
# Sprockets.register_engine '.elm', Elm::Template
