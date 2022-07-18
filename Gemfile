source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '6.0.3'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'factory_bot_rails'

gem 'faker'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 4.0.0'
  gem 'rails-controller-testing'
  gem 'dotenv-rails'
  # Use faker to generate fake data

end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Linters & code smell detectors
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'rubocop-thread_safety'
  gem 'reek', require: false
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Use Devise for user authentication
gem 'devise'
gem 'devise-i18n'

# Use CanCanCan for authorization
gem 'cancancan'

# Use inline_svg for easy inline SVG image display
gem 'inline_svg'

# Use simple_form for forms
gem 'simple_form'

# Use breadcrumbs_on_rails for breadcrumbs
gem 'breadcrumbs_on_rails'

# Use sidekiq for background jobs
gem 'sidekiq', '~> 6.0'

# Use kaminari for pagination
gem 'kaminari'

# Use i18n_generators to generate translations
gem 'i18n_generators'

# Use active_storage_validations to validate attachments
gem 'active_storage_validations'
# Optional, to use :dimension validator or :aspect_ratio validator
gem 'mini_magick', '>= 4.9.5'

# SCORM Cloud API V2 Client
gem 'rustici_software_cloud_v2', '~> 1.1'

# Use S3 SDK for Active Storage
gem 'aws-sdk-s3'

# Use deep_cloneable for easy ActiveRecord cloning
gem 'deep_cloneable', '~> 3.0.0'

# Use for validating dates
gem 'date_validator'

# Use for easy sorting of items
gem 'acts_as_list'

# Use for drag and drop
gem 'jquery-ui-rails'

# Use for pubnub
gem 'pubnub', '~> 4.6.0'

# Use gon for passign pubnub env var to JS
gem 'gon'

# Use sidekiq-sheduler for running sheduled tasks
gem 'sidekiq-scheduler'

# Use discard for soft delete
gem 'discard', '~> 1.2'

# Use ddtrace for traces
#gem 'ddtrace', require: 'ddtrace/auto_instrument'

# Use rack-attack for rate limiting
gem 'rack-attack'

# Use devise-security to controll concurrent sessions
gem 'devise-security'

# Use mail_from to configur contact us form
gem 'mail_form'