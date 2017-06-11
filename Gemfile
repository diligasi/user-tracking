source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Essential Gems ###############################################################
gem 'rails', '~> 5.0.3'
gem 'pg', '~> 0.18'
gem 'mongoid', '~> 6.1.0'
gem 'puma', '~> 3.0'

# Redis
gem 'redis', '~> 3.0'
gem 'redis-rails'
gem 'redis-namespace'
gem 'redis-objects'

# Sidekiq
gem 'sidekiq', '~> 4.2.0'
gem 'sidekiq-scheduler', '~> 2.0'

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Integrations Gems ############################################################
gem 'rack-cors', require: 'rack/cors'

# Extensions Gems ##############################################################
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'dry-validation'
gem 'bootstrap-sass', '~> 3.3.6'

# Assets Gems ##################################################################
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'therubyracer', platforms: :ruby

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
