source 'https://rubygems.org'
ruby '2.2.1'
gem 'rails', '4.2.1'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'bootstrap-sass'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'simple_form'
gem 'slim-rails'
gem 'business_time'
gem 'holidays'
gem 'pry-rails'
gem 'pry-byebug'
#gem 'mysql2', '~> 0.3.20'
gem 'mysql2', '~> 0.3.18'

# Added by Roland
gem 'figaro', '>= 1.0'
gem 'restforce'
gem 'jiralicious', :git => "git://github.com/dorack/jiralicious"
gem 'RedCloth'
gem 'redcarpet', '~> 2.1.1'
gem 'databasedotcom'
gem 'chronic'
gem 'money', :git => 'git://github.com/RubyMoney/money'
gem 'money-rails', :git => 'git://github.com/RubyMoney/money-rails'
gem 'gmail', :git => 'git://github.com/gmailgem/gmail.git'
gem 'yaml_db', github: 'jetthoughts/yaml_db', ref: 'fb4b6bd7e12de3cffa93e0a298a1e5253d7e92ba'

group :development do
  gem 'better_errors'
  #gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'binding_of_caller'
  gem 'guard-bundler'
  gem 'guard-cucumber'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'hub', :require=>nil
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
end
group :development, :test do
  gem 'factory_girl_rails' , "~> 4.0"
  gem 'rspec-rails'
  gem 'thin'
  # gem 'webmock'
  # gem 'vcr'
end
group :production do
  gem 'unicorn'
  gem 'rails_12factor'
  gem 'newrelic_rpm'
end
group :test do
  gem 'capybara'
  gem 'cucumber-rails', :require=>false
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
  gem 'launchy'
  gem 'fuubar'
end
# 2015-07-07
gem 'whenever'
