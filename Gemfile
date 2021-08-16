source 'https://rubygems.org'
ruby '2.6.6'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails',      '6.0.3.6'
gem 'aws-sdk-s3', '1.46.0', require: false
gem 'active_storage_validations', '0.8.2'
gem 'image_processing',           '1.9.3'
gem 'mini_magick',                '4.9.5'
gem 'bcrypt', '3.1.12' #ハッシュ関数
gem 'faker', '2.1.2' #ありそうなユーザ名を作成するgem
gem 'bootstrap-sass', '3.3.7'
gem 'puma',       '4.3.5'
gem 'sass-rails', '6.0.0'
gem 'webpacker',  '4.2.2'
gem 'turbolinks', '5.2.1'
gem 'jbuilder',   '2.10.0'
gem 'bootsnap',   '1.4.6', require: false
gem 'will_paginate',           '3.1.8'
gem 'bootstrap-will_paginate', '1.0.0'
gem 'rails-i18n'
gem 'rails_admin', '~> 2.0' #管理画面のgem
gem 'pg', '1.2.3'

group :development, :test do
  # gem 'sqlite3', '1.4.2'
  gem 'byebug',  '11.1.3', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails'
end

group :development do
  gem 'web-console',           '4.0.2'
  gem 'listen',                '3.2.1'
  gem 'spring',                '2.1.0'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'capistrano', '~> 3.10', require: false
  gem 'capistrano-rails', '~> 1.3', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rbenv', require: false
end

group :test do
  gem 'capybara',                 '3.32.2'
  gem 'selenium-webdriver',       '3.142.7'
  gem 'webdrivers',               '4.3.0'
  gem 'rails-controller-testing', '1.0.4'
  gem 'minitest',                 '5.11.3'
  gem 'minitest-reporters',       '1.3.8'
  # gem 'guard',                    '2.16.2'#自動化テストのためのもの
  # gem 'guard-minitest',           '2.4.6'
end

group :production do
  # gem 'pg', '1.2.3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# Uncomment the following line if you're running Rails
# on a native Windows system:
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]