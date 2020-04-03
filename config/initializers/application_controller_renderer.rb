# Be sure to restart your server when you modify this file.

# ActiveSupport::Reloader.to_prepare do
#   ApplicationController.renderer.defaults.merge!(
#     http_host: 'example.org',
#     https: false
#   )
# end

Rails.application.config.assets.precompile += %w( admin.sass )
Rails.application.config.assets.precompile += %w( admin.js )
Rails.application.config.assets.precompile += %w( rider.sass )
Rails.application.config.assets.precompile += %w( rider.js )
Rails.application.config.assets.precompile += %w( chef.sass )
Rails.application.config.assets.precompile += %w( chef.js )