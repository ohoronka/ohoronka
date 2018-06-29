source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.0.rc2'
# Use mysql as the database for Active Record
# gem 'mysql2', '>= 0.3.18', '< 0.5'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'

# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :test do
  gem 'webmock'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.5'
  gem 'pry-rails', require: false
  gem 'letter_opener', require: false
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'vcr', require: false
  gem 'factory_bot_rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'hirb'

  gem "capistrano", "3.10.2", require: false
  gem "capistrano-rails", "~> 1.3", require: false
  gem 'capistrano-rvm'
  gem 'capistrano-bundler', '~> 1.2'
  gem 'capistrano3-puma', github: "seuros/capistrano-puma"
  gem 'capistrano-sidekiq'
  gem 'annotate', require: false
  # gem 'capistrano-local-precompile', '~> 1.1.1', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'mqtt'
gem 'redis-rails'
gem 'sidekiq'
gem 'draper'
gem 'bootstrap_form', '~> 2.7'
gem 'hirb', require: false
gem 'telegram-bot-ruby'
gem 'activerecord-typedstore'
gem 'bootstrap', '~> 4.1.1'
gem 'font-awesome-sass'
gem 'carrierwave', '~> 1.0'
gem 'rmagick'
gem 'bugsnag'
gem 'fog'
gem 'kaminari'
gem 'bootstrap4-kaminari-views'
# gem 'firebase'
# gem 'fcm'
gem 'fcm_pusher'
gem 'nova_poshta'
gem 'liqpay', github: 'liqpay/sdk-ruby'
gem 'premailer-rails'
gem 'datagrid'
gem 'webpacker', '~> 3.2'
gem 'react-rails'
gem 'i18n-js'
