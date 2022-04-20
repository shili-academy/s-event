# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.7.4"

gem "bootsnap", ">= 1.4.4", require: false
gem "bootstrap-kaminari-views"
gem "bootstrap", "~> 5.1.3"
gem "breadcrumbs_on_rails"
gem "chartkick"
gem "cancancan"
gem "carrierwave"
gem "config"
gem "devise"
gem "faker", "2.1.2"
gem "figaro"
gem "font-awesome-rails"
gem "gon"
gem "groupdate"
gem "hotwire-rails"
gem "jquery-rails"
gem "jpbuilder"
gem "kaminari"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.4", ">= 6.1.4.4"
gem "rails-i18n"
gem "redis", "~> 4.0"
gem "sass-rails", ">= 6"
gem "fullcalendar-rails"
gem "momentjs-rails"
gem "popper_js", "~> 2.9.3"
gem "turbolinks", "~> 5"
gem "wdm", ">= 0.1.0" if Gem.win_platform?
gem "sprockets-rails", "2.3.3"
gem "rails_admin"
gem "ransack"
gem "mysql2", "~> 0.5.0"
gem "google_visualr", "~> 2.5.1"

gem "webpacker", "~> 5.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "sqlite3", "~> 1.4"
  gem "rubocop", "~> 0.74.0", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.3.2", require: false
end

group :development do
  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 2.0"
  gem "spring"
  gem "web-console", ">= 4.1.0"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
  gem "webdrivers"
end

group :production do
  gem "pg"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
