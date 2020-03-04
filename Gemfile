source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
gem 'activerecord-import'
gem 'rails', '~> 5.1.4'
# Use mysql as the database for Active Record
gem 'pg'
gem 'puma', '~> 3.7'
gem 'city-state'
gem 'geocoder'
gem "paperclip", "~> 5.0.0"
gem 'paperclip-optimizer'
gem 'sweetalert-rails'
gem 'rubyzip', '>= 1.0.0'
gem 'zip-zip'
gem 'friendly_id', '~> 5.1.0'
gem 'bundler'
gem 'gmaps4rails'
gem 'sendgrid-ruby'
# Auth
gem 'devise', '~> 4.4'
gem 'bootstrap-tooltip-rails'

# Front-end
gem 'slim'
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'font-awesome-sass', '~> 4.5'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails', '~> 4.3'
gem 'jquery-ui-rails', '~> 6.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem "parsley-rails"
gem 'gon'
gem "recaptcha", require: "recaptcha/rails"
gem "figaro"
gem 'will_paginate', '~> 3.1.0'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.37'
gem "select2-rails"

#Translation
gem 'globalize', '~> 5.1.0.beta2'
gem 'globalize-accessors'
gem 'nicescroll-rails'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'pry-rails', '~> 0.3.6'
end

group :development do
  gem "rails_best_practices"
  gem 'rack-mini-profiler', '~> 0.10.7', require: false
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'annotate'
  gem 'bullet'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
