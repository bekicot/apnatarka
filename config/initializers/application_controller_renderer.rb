# Be sure to restart your server when you modify this file.

# ActiveSupport::Reloader.to_prepare do
#   ApplicationController.renderer.defaults.merge!(
#     http_host: 'example.org',
#     https: false
#   )
# end

Rails.application.config.assets.precompile += %w( admin.sass )
Rails.application.config.assets.precompile += %w( admin.js )