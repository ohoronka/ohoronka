source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '5.2.2'
gem 'pg'
gem 'puma'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'turbolinks'
gem 'bcrypt', '~> 3.1.7'

group :test do
  gem 'webmock'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'vcr', require: false
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

group :development, :test do
  gem 'pry-rails', require: false
  gem 'letter_opener', require: false
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'hirb'

  gem "capistrano", "3.10.2", require: false
  gem "capistrano-rails", "~> 1.3", require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma', require: false
  gem 'capistrano-sidekiq', require: false
  gem 'annotate', require: false
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
end

gem 'mqtt'
gem 'redis-rails'
gem 'sidekiq'
gem 'draper'
gem 'bootstrap_form'
gem 'hirb', require: false
gem 'telegram-bot-ruby'
gem 'activerecord-typedstore'
gem 'bootstrap'
gem 'font-awesome-sass'
gem 'carrierwave'
gem 'rmagick'
gem 'bugsnag'
gem 'fog-aws'
gem 'kaminari'
gem 'bootstrap4-kaminari-views'
gem 'fcm_pusher'
gem 'nova_poshta'
gem 'liqpay', github: 'liqpay/sdk-ruby'
gem 'premailer-rails'
gem 'datagrid'
gem 'webpacker'
gem 'react-rails'
gem 'i18n-js'
gem 'bootsnap'
